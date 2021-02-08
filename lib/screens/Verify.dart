import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phone_login/screens/home.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = _auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkemailverified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkemailverified() async {
    user = _auth.currentUser;
    user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Get.off(Home());
      Fluttertoast.showToast(msg: "User Registered Successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "An email has been sent to\n${user.email}\nPlease verify to login automatically",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: MediaQuery.of(context).size.height / 50,
            ),
          ),
        ),
      ),
    );
  }
}
