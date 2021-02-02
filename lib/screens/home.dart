import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/todoController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/widgets/drawer.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/widgets/todoAlert.dart';
import 'package:phone_login/widgets/todoCard.dart';

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
        return Text((_userController.user == null)
            ? ""
            : _userController.user.name.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Logout"),
            content: new Text("Do you want to logout?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Get.back();
                },
              ),
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  Get.reset();
                  Get.lazyPut(() => AuthController());
                  Get.lazyPut(() => UserController());
                  _authController.logOut();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      drawer: Home_drawer(),
      appBar: AppBar(
        title: getUserName(),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _showDialog,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
                color: Colors.blue),
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
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  value: 10,
                )));
              }
            },
          )
        ],
      ),
    );
  }
}
