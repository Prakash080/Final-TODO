import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/screens/profile.dart';
import 'package:phone_login/services/fireDB.dart';

class Home_drawer extends GetWidget<AuthController> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var mainColor = Color(0xff2470c7);
  @override
  Widget build(BuildContext context) {
    var _email = _auth.currentUser.email.toString();

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
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).size.height / 60),
          );
        },
      );
    }

    void _showDialog() {
      Get.defaultDialog(
        title: "Do you want to Logout?",
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
              onPressed: () {
                Get.reset();
                Get.lazyPut(() => AuthController());
                Get.lazyPut(() => UserController());
                controller.logOut();
              },
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

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
            color: mainColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Image(
                          image: AssetImage("assets/ICON.png"),
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1)),
                  getUserName(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(_email,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 60,
                      )),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text("Home",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 50,
                  )),
              onTap: () {
                Get.back();
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 50,
                  )),
              onTap: () {
                Get.to(profile(), arguments: _email);
              },
            ),
          ),
          Card(
              child: ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: MediaQuery.of(context).size.height / 50,
                )),
            onTap: _showDialog,
            // flutter defined function
          ))
        ],
      ),
    );
  }
}
