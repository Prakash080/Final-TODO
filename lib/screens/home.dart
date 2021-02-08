import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/todoController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/widgets/drawer.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/widgets/todoAlert.dart';
import 'package:phone_login/widgets/todoCard.dart';
import 'package:phone_login/widgets/loading.dart';

class Home extends StatelessWidget {
  final AuthController _authController = Get.find();

  getUserName() {
    return GetX<UserController>(
      init: Get.put(UserController()),
      initState: (_) async {
        Get.find<UserController>().user =
            await FireDb().getUser(Get.find<AuthController>().user.uid);
      },
      builder: (_userController) {
        return Text(
            (_userController.user == null)
                ? ""
                : _userController.user.name.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Montserrat'));
      },
    );
  }

  Future<bool> _onbackpressed() {
    return Get.defaultDialog(
      title: "Exit?",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            elevation: 10.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          RaisedButton(
            elevation: 10.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            onPressed: () => exit(0),
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
        drawer: Home_drawer(),
        appBar: AppBar(
          backgroundColor: mainColor,
          title: getUserName(),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Icon(Icons.exit_to_app),
                  onTap: _onbackpressed,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          child: Icon(Icons.add),
          onPressed: () {
            TodoAlert().addTodoDailog();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your Todos",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 25,
                  fontWeight: FontWeight.bold,
                  color: mainColor),
            ),
            GetX<TodoController>(
              init: Get.put<TodoController>(TodoController()),
              builder: (TodoController todoController) {
                if (todoController != null && todoController.todos != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (_, index) {
                        return TodoCard(
                            uid: _authController.user.uid,
                            todo: todoController.todos[index]);
                      },
                    ),
                  );
                } else {
                  Get.to(Loading());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
