import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';

class AuthBinginds extends Bindings {
  
  @override
  void dependencies() {
    Get.put(AuthController());
    
  }
}