import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/screens/login.dart';
import 'package:phone_login/widgets/loading.dart';

class GSignUp extends StatefulWidget {
  @override
  _GSignUpState createState() => _GSignUpState();
}

class _GSignUpState extends State<GSignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumber_c = TextEditingController();
  final TextEditingController confirmpass_c = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  bool _showPassword1 = true;
  bool _showPassword2 = true;
  var g_name = Get.arguments[0];
  var g_mail = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    if (g_name != null && g_mail != null) {
      nameController.text = g_name.toString();
      emailController.text = g_mail.toString();
    } else {
      nameController.text = "";
      emailController.text = "";
    }
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              backgroundColor: mainColor,
              body: SingleChildScrollView(
                child: Stack(children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image(
                                    image: AssetImage("assets/ICON.png"),
                                    width: MediaQuery.of(context).size.height *
                                        0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.1))
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Form(
                                        key: formkey,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Register",
                                                    style: TextStyle(
                                                      color: mainColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: TextFormField(
                                                  enabled: false,
                                                  controller: nameController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.person,
                                                      color: mainColor,
                                                    ),
                                                    labelText: 'Full Name',
                                                    labelStyle: TextStyle(
                                                      color: mainColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: TextFormField(
                                                  enabled: false,
                                                  controller: emailController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.email,
                                                      color: mainColor,
                                                    ),
                                                    labelText: 'E-mail',
                                                    labelStyle: TextStyle(
                                                      color: mainColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: TextFormField(
                                                  controller: phonenumber_c,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.phone_android,
                                                      color: mainColor,
                                                    ),
                                                    labelText: 'Phone Number',
                                                    labelStyle: TextStyle(
                                                      color: mainColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'Mobile number is required';
                                                    }
                                                    if (!RegExp(
                                                            r"^(\+91)?(-)?\s*?(91)?\s*?(\d{3})-?\s*?(\d{3})-?\s*?(\d{4})")
                                                        .hasMatch(value)) {
                                                      return 'Please enter a valid Mobile number';
                                                    }
                                                  },
                                                  onSaved: (String value) {
                                                    phonenumber_c.text = value;
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
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Enter OTP",
                                                      ),
                                                      enabled: false,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            45,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(5)),
                                                  Container(
                                                    height: 0.8 *
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            20),
                                                    width: 3 *
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10),
                                                    child: RaisedButton(
                                                      elevation: 10.0,
                                                      color: Colors.grey,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      onPressed: () {},
                                                      child: Text(
                                                        "Send OTP",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: TextFormField(
                                                  controller:
                                                      passwordController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: _showPassword1,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.lock_outline,
                                                      color: mainColor,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _showPassword1 =
                                                              !_showPassword1;
                                                        });
                                                      },
                                                      child: Icon(
                                                          _showPassword1
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility,
                                                          color: mainColor),
                                                    ),
                                                    labelText:
                                                        'Create Password',
                                                    labelStyle: TextStyle(
                                                      color: mainColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'Password is required';
                                                    }
                                                    if (!RegExp(
                                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                                        .hasMatch(value)) {
                                                      return "Password should contain atleast\n* 8 characters *[A-Z] *[a-z] *[0-9] *[!,#,%,&,*,?,^,@]";
                                                    }
                                                  },
                                                  onSaved: (String value) {
                                                    passwordController.text =
                                                        value;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: TextFormField(
                                                  controller: confirmpass_c,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: _showPassword2,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.lock,
                                                      color: mainColor,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _showPassword2 =
                                                              !_showPassword2;
                                                        });
                                                      },
                                                      child: Icon(
                                                          _showPassword2
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility,
                                                          color: mainColor),
                                                    ),
                                                    labelText:
                                                        'Confirm Password',
                                                    labelStyle: TextStyle(
                                                      color: mainColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'Confirm password';
                                                    }
                                                    if (value !=
                                                        passwordController
                                                            .text) {
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
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    child: RaisedButton(
                                                      elevation: 10.0,
                                                      color: mainColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      onPressed: () =>
                                                          Get.offAll(Login()),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              45,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(5)),
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
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    child: RaisedButton(
                                                      elevation: 10.0,
                                                      color: mainColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      onPressed: () {
                                                        Get.to(Loading());
                                                        if (!formkey
                                                            .currentState
                                                            .validate()) {
                                                          Get.back();
                                                          return;
                                                        }
                                                        formkey.currentState
                                                            .save();
                                                        _authController
                                                            .createUser(
                                                                nameController
                                                                    .text,
                                                                emailController
                                                                    .text,
                                                                passwordController
                                                                    .text);
                                                      },
                                                      child: Text(
                                                        "Register",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              45,
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
              ))),
    );
  }
}
