import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/userController.dart';
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
            autofocus: true,
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
              FlatButton(
                child: Text(
                  "Add",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    FireDb().addTodo(
                        _textEditingController.text, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
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
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
              FlatButton(
                child: Text(
                  "Update",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    todoModel.content = _textEditingController.text;
                    FireDb().updateTodo(todoModel, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ]);
  }
}
