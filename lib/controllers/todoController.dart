import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/models/todo.dart';
import 'package:phone_login/services/fireDB.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;

  @override
  @mustCallSuper
  void onInit() async {
  
    clear();
    Get.find<UserController>().user =
        await FireDb().getUser(Get.find<AuthController>().user.uid);
    var user = Get.find<UserController>().user;

    todoList.bindStream(FireDb()
        .todoStream(user.id)); 
    super.onInit();
  }

  void clear() {
    this.todoList.value = List<TodoModel>();
  }
}
