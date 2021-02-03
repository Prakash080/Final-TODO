import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/screens/login.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumber_c = TextEditingController();
  final TextEditingController confirmpass_c = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfff2f3f7),
            body: SingleChildScrollView(
              child: Stack(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70),
                      ),
                    ),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'To-Do',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                      Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Form(
                              key: formkey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Register",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: nameController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: mainColor,
                                            ),
                                            labelText: 'Full Name'),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Name is required';
                                          }
                                          if (value.length < 3 ||
                                              value.contains(
                                                  new RegExp(r'^[0-9]'), 1)) {
                                            return 'Please enter a full name';
                                          }
                                        },
                                        onSaved: (String value) {
                                          nameController.text = value;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: emailController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: mainColor,
                                          ),
                                          labelText: 'E-mail',
                                        ),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Email is required';
                                          }
                                          if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                            return 'Please enter a valid email address';
                                          }
                                        },
                                        onSaved: (String value) {
                                          emailController.text = value;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: mainColor,
                                          ),
                                          labelText: 'Create Password',
                                        ),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          }
                                          if (!RegExp(
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                              .hasMatch(value)) {
                                            return 'Password should contain atleast\n* 8 characters\n*one upper case\n*one lower case\n*one digit[0-9]\n*one Special character';
                                          }
                                        },
                                        onSaved: (String value) {
                                          passwordController.text = value;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: confirmpass_c,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: mainColor,
                                          ),
                                          labelText: 'Confirm Password',
                                        ),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Confirm password';
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return 'Check your password';
                                          }
                                        },
                                        onSaved: (String value) {
                                          confirmpass_c.text = value;
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 1 *
                                              (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20),
                                          width: 3 *
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10),
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            color: mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            onPressed: () => Get.to(Login()),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.5,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Container(
                                          height: 1 *
                                              (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20),
                                          width: 3 *
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10),
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            color: mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            onPressed: () async {
                                              RegisterUser();
                                            },
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.5,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    40,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                            )))
                  ])
                ])
              ]),
            )));
  }

  void RegisterUser() {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    controller.createUser(
        nameController.text, emailController.text, passwordController.text);
  }
}
