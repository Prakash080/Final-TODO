import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/models/todo.dart';
import 'package:phone_login/services/fireDB.dart';

class TodoAlert {
  TextEditingController _textEditingController = TextEditingController();
  UserController _userController = Get.find();

  addTodoDailog() {
    Get.defaultDialog(
        title: "Add new todo",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            cursorColor: mainColor,
            autofocus: true,
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
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
                  _textEditingController.clear();
                  Get.back();
                },
                child: Text(
                  "Cancel",
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
                onPressed: () {
                  if (_textEditingController.text != "") {
                    FireDb().addTodo(
                        _textEditingController.text, _userController.user.id);
                    _textEditingController.clear();

                    Get.back();
                    Fluttertoast.showToast(
                        msg: "Todo Added", backgroundColor: Colors.grey);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ]);
  }

  editTodoDailog(TodoModel todoModel) {
    _textEditingController.text = todoModel.content;
    Get.defaultDialog(
        title: "Edit todo",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            autofocus: true,
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
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
                  _textEditingController.clear();
                  Get.back();
                },
                child: Text(
                  "Cancel",
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
                onPressed: () {
                  if (_textEditingController.text != "") {
                    todoModel.content = _textEditingController.text;
                    FireDb().updateTodo(todoModel, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                    Fluttertoast.showToast(
                        msg: "Todo Updated", backgroundColor: Colors.grey);
                  }
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            ],
          ),
        ]);
  }
}
