import 'dart:io';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/user.dart';
import 'package:phone_login/services/fireDB.dart';
import 'storageController.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel userVal) => this._userModel.value = userVal;

  getUser() async {
    var fireuser = Get.find<AuthController>().user;
    if (fireuser != null) {
      this.user = await FireDb().getUser(fireuser.uid);
    }
  }

  void clear() {
    _userModel.value = UserModel();
  }

  Future<String> uploadprofilepicture(File image) async {
    var downloadUrl = await storageController().uploadFile(image);
    return downloadUrl;
  }
}
