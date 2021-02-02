import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/bindings/authBindings.dart';
import 'package:phone_login/utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinginds(),
      home: Root(),
      debugShowCheckedModeBanner: false,
    );
  }
}
