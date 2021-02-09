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
import 'package:phone_login/widgets/loading.dart';

class AuthController extends GetxController {
  String errorMessage;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _fireUser = Rx<User>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User get user => _fireUser.value;

  @override
  void onInit() {
    _fireUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String name, String email, String password, String phone,
      String photoURL) async {
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
          phone: phone,
          photoURL: photoURL);

      var rs = await FireDb().createNewUser(_user);
      if (rs) {
        Get.find<UserController>().user = _user;
        Get.back();
        Get.off(VerifyPage());
      }
    } catch (e) {
      Get.back();
      switch (e.code) {
        case "email-already-in-use":
          Fluttertoast.showToast(
              msg: "Your email already exist", backgroundColor: Colors.black);
          break;
        case "invalid-email":
          Fluttertoast.showToast(
              msg: "Your email is invalid,please enter valid email",
              backgroundColor: Colors.black);
          break;
        case "operation-not-allowed":
          Fluttertoast.showToast(
              msg: "Database error", backgroundColor: Colors.black);
          break;
        case "weak-password":
          Fluttertoast.showToast(
              msg: "Your password is too week", backgroundColor: Colors.black);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Error while registering an account",
              backgroundColor: Colors.black);
      }
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
      Fluttertoast.showToast(
          msg: "Login Successful", backgroundColor: Colors.black);
    } catch (e) {
      Get.back();
      switch (e.code) {
        case "invalid-email":
          Fluttertoast.showToast(
              msg: "Your email address is invalid",
              backgroundColor: Colors.black);
          break;
        case "wrong-password":
          Fluttertoast.showToast(
              msg: "Your password is wrong.", backgroundColor: Colors.black);

          break;
        case "user-not-found":
          Fluttertoast.showToast(
              msg: "User with this email doesn't exist.",
              backgroundColor: Colors.black);
          break;
        case "user-disabled":
          Fluttertoast.showToast(
              msg: "User with this email has been disabled.",
              backgroundColor: Colors.black);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Recheck your email and password",
              backgroundColor: Colors.black);
      }
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
      Fluttertoast.showToast(
          msg: "Password Reset email link has been sent",
          backgroundColor: Colors.black);
    }).catchError((onError) {
      Get.back();
      Fluttertoast.showToast(
          msg: onError.message, backgroundColor: Colors.black);
    });
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      FireDb().deleteNewUser(user.uid);
      value.user.delete().then((res) {
        Get.back();
        Get.offAll(Login());
        googleSignIn.signOut();
        Fluttertoast.showToast(
            msg: "User account deleted successfully",
            backgroundColor: Colors.black);
      });
    }).catchError((e) {
      Get.back();
      switch (e.code) {
        case "invalid-email":
          Fluttertoast.showToast(
              msg: "Your email address is invalid",
              backgroundColor: Colors.black);
          break;
        case "wrong-password":
          Fluttertoast.showToast(
              msg: "Your password is wrong.", backgroundColor: Colors.black);

          break;
        case "user-not-found":
          Fluttertoast.showToast(
              msg: "User with this email doesn't exist.",
              backgroundColor: Colors.black);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Recheck your email and password",
              backgroundColor: Colors.black);
      }
    });
  }

  Future<void> google_signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    Get.to(Loading());
    final AuthCredential authcredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await _auth.signInWithCredential(authcredential);

    final User user = userCredential.user;
    assert(user.displayName != null);
    assert(user.email != null);
    try {
      Get.back();
      Get.to(GSignUp(), arguments: [user.displayName, user.email]);
      user.delete();
    } catch (e) {
      Get.back();
      switch (e.code) {
        case "invalid-email":
          Fluttertoast.showToast(
              msg: "Your email address is invalid",
              backgroundColor: Colors.black);
          break;
        case "wrong-password":
          Fluttertoast.showToast(
              msg: "Your password is wrong.", backgroundColor: Colors.black);

          break;
        case "user-not-found":
          Fluttertoast.showToast(
              msg: "User with this email doesn't exist.",
              backgroundColor: Colors.black);
          break;
        case "user-disabled":
          Fluttertoast.showToast(
              msg: "User with this email has been disabled.",
              backgroundColor: Colors.black);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Recheck your email and password",
              backgroundColor: Colors.black);
      }
    }
  }

  Future<bool> checkcurrentpassword(String currpassword) async {
    return await validatepassword(currpassword);
  }

  Future<bool> validatepassword(String password) async {
    var firebaseuser = _auth.currentUser;
    var authcredential = EmailAuthProvider.credential(
        email: firebaseuser.email, password: password);
    try {
      var authresult =
          await firebaseuser.reauthenticateWithCredential(authcredential);
      return authresult.user != null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.message, backgroundColor: Colors.black);
      return false;
    }
  }

  void updateuserpassword(String newpassword) async {
    var firebaseuser = _auth.currentUser;
    firebaseuser.updatePassword(newpassword);
    Get.back();
    Get.off(Home());
    Fluttertoast.showToast(
        msg: "Password updated successfully", backgroundColor: Colors.black);
  }
}
