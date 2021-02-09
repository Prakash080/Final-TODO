import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_login/models/todo.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/widgets/todoAlert.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;
  const TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
        todo.dateCreated.microsecondsSinceEpoch);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Text(todo.content,
              style: todo.done
                  ? TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 50,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    )
                  : TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 50,
                    )),
          subtitle: Text("Created on:${DateFormat('dd/MM/yyyy').format(date)}"),
          leading: Checkbox(
            value: todo.done,
            onChanged: (newValue) {
              if (newValue == true)
                Fluttertoast.showToast(
                    msg: "Todo Completed, you can delete the todo",
                    backgroundColor: Colors.black);
              todo.done = newValue;
              FireDb().updateTodo(
                todo,
                uid,
              );
            },
          ),
          trailing: IconButton(
              icon: Icon(todo.done ? Icons.delete_forever : Icons.edit),
              onPressed: () {
                if (todo.done) {
                  FireDb().deleteTodo(todo, uid);
                  Fluttertoast.showToast(
                      msg: "Todo Deleted", backgroundColor: Colors.black);
                } else {
                  TodoAlert().editTodoDailog(todo);
                }
              }),
        ),
      ),
    );
  }
}
