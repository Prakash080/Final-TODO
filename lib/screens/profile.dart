import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/controllers/userController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/screens/deleteaccount.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/services/fireDB.dart';
import 'package:phone_login/screens/changepassword.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_login/widgets/loading.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final imagePicker = ImagePicker();

  Widget build(BuildContext context) {
    getUserimage() {
      return GetX<UserController>(
        init: Get.put(UserController()),
        initState: (_) async {
          Get.find<UserController>().user =
              await FireDb().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (_userController) {
          return CircleAvatar(
            backgroundImage: NetworkImage(_userController.user.photoURL),
            radius: 5 * MediaQuery.of(context).size.height / 50,
          );
        },
      );
    }

    Widget imageProfile() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            getUserimage(),
            SizedBox(height: MediaQuery.of(context).size.height / 70),
            InkWell(
              onTap: () async {
                var status = await Permission.storage.status;
                if (status.isGranted) {
                  var pickefile =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  File image = File(pickefile.path);
                  Get.to(Loading());
                  await UserController().uploadprofilepicture(image);
                  setState(() {
                    getUserimage();
                  });
                } else {
                  PermissionStatus permissionStatus =
                      await Permission.storage.request();
                  print("permissionStatus:${permissionStatus.isGranted}");
                }
              },
              child: Text("Choose from gallery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 50,
                  )),
            )
          ],
        ),
      );
    }

    getUserName() {
      return GetX<UserController>(
        init: Get.put(UserController()),
        initState: (_) async {
          Get.find<UserController>().user =
              await FireDb().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (_userController) {
          return Text(
            _userController.user.name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: MediaQuery.of(context).size.height / 50,
            ),
          );
        },
      );
    }

    getUseremail() {
      return GetX<UserController>(
        init: Get.put(UserController()),
        initState: (_) async {
          Get.find<UserController>().user =
              await FireDb().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (_userController) {
          return Text(
            _userController.user.email.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: MediaQuery.of(context).size.height / 50,
            ),
          );
        },
      );
    }

    getUserphone() {
      return GetX<UserController>(
        init: Get.put(UserController()),
        initState: (_) async {
          Get.find<UserController>().user =
              await FireDb().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (_userController) {
          return Text(
            _userController.user.phone.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: MediaQuery.of(context).size.height / 50,
            ),
          );
        },
      );
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        imageProfile(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "User Profile",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                30,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      "Name:",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                    )),
                                getUserName(),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      "Email:",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                    )),
                                getUseremail(),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      "Mobile number:",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                    )),
                                getUserphone(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 1 *
                                          (MediaQuery.of(context).size.height /
                                              20),
                                      width: 6 *
                                          (MediaQuery.of(context).size.width /
                                              10),
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 10),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30)),
                                        ),
                                        onPressed: () {
                                          Get.to(DeleteAccount());
                                        },
                                        child: Text(
                                          "Delete Account",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 1 *
                                          (MediaQuery.of(context).size.height /
                                              20),
                                      width: 6 *
                                          (MediaQuery.of(context).size.width /
                                              10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30)),
                                        ),
                                        onPressed: () =>
                                            Get.to(ChangePassword()),
                                        child: Text(
                                          "Change Password",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 1 *
                                          (MediaQuery.of(context).size.height /
                                              20),
                                      width: 6 *
                                          (MediaQuery.of(context).size.width /
                                              10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30)),
                                        ),
                                        onPressed: () => Get.off(Home()),
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
