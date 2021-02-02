import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/main.dart';
import 'package:phone_login/models/user.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/screens/login.dart';
import 'package:phone_login/screens/verification.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/utils/root.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _fireUser = Rx<User>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController _codeController = TextEditingController();

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
          name: name);

      var rs = await FireDb().createNewUser(_user);
      if (rs) {
        _auth.currentUser.sendEmailVerification();
        Get.find<UserController>().user = _user;
        Get.offAll(Home());
        Get.snackbar("User Registered Successfully", "Welcome");
      }
    } catch (e) {
      getErrorSnack("Error While Creating Account", e.message);
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
      Get.snackbar("Login Successful", "Welcome");
    } catch (e) {
      getErrorSnack("Error While SignIn Account", e.message);
    }
  }

  Future logOut() async {
    await _auth.signOut();
    Get.offAll(Root());
  }

  void getErrorSnack(String title, String message) {
    Get.snackbar(title, message,
        snackPosition:
            SnackPosition.BOTTOM); // For Checking Error form Firebase
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(Login());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError(
        (onError) => getErrorSnack("Error In Email Reset", onError.message));
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        Get.offAll(Login());
        Get.snackbar("User Account Deleted ", "Success");
      });
    }).catchError((onError) => getErrorSnack("Credential Error", "Failed"));
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
    print(user.uid);
    assert(user.displayName != null);
    assert(user.email != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    try {
      UserModel _user = UserModel(
        id: user.uid,
        email: user.email,
        name: user.displayName,
      );

      var rs = await FireDb().createNewUser(_user);
      if (rs) {
        Get.find<UserController>().user = _user;
        Get.offAll(Home());
        Get.snackbar("Login Successful", "Welcome");
      }
    } catch (e) {
      getErrorSnack("Error While Logging in", e.message);
    }
  }

  Future<bool> phoneverification(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 5),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User user = result.user;

          if (user != null) {
            Get.to(Home());
          } else {
            print("Error");
          }
          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (Exception exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        UserCredential result =
                            await _auth.signInWithCredential(credential);

                        User user = result.user;

                        if (user != null) {
                          Get.to(Home());
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}
