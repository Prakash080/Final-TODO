import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/screens/deleteaccount.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/screens/login.dart';

class Home_drawer extends GetWidget<AuthController> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var mainColor = Color(0xff2470c7);
  @override
  Widget build(BuildContext context) {
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
                  Text(_auth.currentUser.uid.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 50,
                      )),
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
                  onTap: () => controller.logOut()))
        ],
      ),
    );
  }
}
