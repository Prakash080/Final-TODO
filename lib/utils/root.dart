import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/screens/login.dart';

class Root extends GetWidget<AuthController> {

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
         
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
