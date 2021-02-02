import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/screens/deleteaccount.dart';
import 'package:phone_login/screens/home.dart';

class Home_drawer extends GetWidget<AuthController> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthController _authController = Get.find();

  var mainColor = Color(0xff2470c7);
  @override
  Widget build(BuildContext context) {
    var _name = _auth.currentUser.displayName;
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

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 100, bottom: 10, left: 10, right: 10),
            color: mainColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                      _name != null ? "Welcome " + _name.toString() : "Welcome",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 50,
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(_auth.currentUser.email.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 50,
                      )),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Your Todos",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 40,
                  )),
              onTap: () {
                User user = _auth.currentUser;
                Get.to(Home());
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Delete Account",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 40,
                  )),
              onTap: () => Get.to(DeleteAccount()),
            ),
          ),
          Card(
              child: ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: MediaQuery.of(context).size.height / 40,
                )),
            onTap: _showDialog,
            // flutter defined function
          ))
        ],
      ),
    );
  }
}
