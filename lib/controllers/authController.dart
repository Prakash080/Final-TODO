import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/models/user.dart';
import 'package:phone_login/screens/Verify.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/screens/login.dart';
import 'package:phone_login/screens/gSignup.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/utils/root.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _fireUser = Rx<User>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User get user => _fireUser.value;

  @override
  void onInit() {
    _fireUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel _user = UserModel(
        id: userCredential.user.uid,
        email: userCredential.user.email,
        name: name,
      );

      var rs = await FireDb().createNewUser(_user);
      if (rs) {
        Get.find<UserController>().user = _user;
        Get.back();
        Get.offAll(VerifyPage());
      }
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: e.message);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.find<UserController>().user =
          await FireDb().getUser(userCredential.user.uid);
      Get.back();
      Get.to(Home());
      Fluttertoast.showToast(msg: "Login Successful");
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: e.message);
    }
  }

  Future logOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(Root());
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.off(Login());
      Fluttertoast.showToast(msg: "Password Reset email link has been sent");
    }).catchError((onError) {
      Get.back();
      Fluttertoast.showToast(msg: onError.message);
    });
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      FireDb().deleteNewUser(user);
      value.user.delete().then((res) {
        Get.back();
        Get.offAll(Login());
        Fluttertoast.showToast(msg: "User account deleted successfully");
      });
    }).catchError((onError) {
      Get.back();
      Fluttertoast.showToast(msg: onError.message);
    });
  }

  Future google_signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authcredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await _auth.signInWithCredential(authcredential);

    final User user = userCredential.user;
    assert(user.displayName != null);
    assert(user.email != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    try {
      Get.back();
      Get.to(GSignUp(), arguments: [user.displayName, user.email]);
      user.delete();
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: e.message);
    }
  }

  Future<bool> checkcurrentpassword(String currpassword) async {
    return await validatepassword(currpassword);
  }

  Future<bool> validatepassword(String password) async {
    var firebaseuser = await _auth.currentUser;
    var authcredential = EmailAuthProvider.credential(
        email: firebaseuser.email, password: password);
    try {
      var authresult =
          await firebaseuser.reauthenticateWithCredential(authcredential);
      return authresult.user != null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.message);
      return false;
    }
  }

  void updateuserpassword(String newpassword) async {
    var firebaseuser = await _auth.currentUser;
    firebaseuser.updatePassword(newpassword);
    Get.back();
    Get.off(Home());
    Fluttertoast.showToast(msg: "Password updated successfully");
  }
}
