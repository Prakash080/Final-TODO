import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/user.dart';
import 'package:phone_login/services/fireDB.dart';

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
}
