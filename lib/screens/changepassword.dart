import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/widgets/loading.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthController _authController = Get.find();
  final TextEditingController current_pass_c = TextEditingController();
  final TextEditingController new_pass_c = TextEditingController();
  final TextEditingController confirm_pass_c = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool checkcurrentpassword = true;
  bool _showPassword1 = true;
  bool _showPassword2 = true;
  bool _showPassword3 = true;
  @override
  Widget build(BuildContext context) {
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
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Image(
                                image: AssetImage("assets/ICON.png"),
                                width: MediaQuery.of(context).size.height * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1))
                      ],
                    ),
                    Form(
                      key: formkey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.68,
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
                                        "Manage Password",
                                        style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextFormField(
                                      controller: current_pass_c,
                                      keyboardType: TextInputType.text,
                                      obscureText: _showPassword1,
                                      decoration: InputDecoration(
                                        errorText: checkcurrentpassword
                                            ? null
                                            : "Plese check your current password",
                                        prefixIcon: Icon(
                                          Icons.vpn_key,
                                          color: mainColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showPassword1 = !_showPassword1;
                                            });
                                          },
                                          child: Icon(
                                              _showPassword1
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: mainColor),
                                        ),
                                        labelText: 'Current Password',
                                        labelStyle: TextStyle(
                                          color: mainColor,
                                          fontSize: MediaQuery.of(context)
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
                                      },
                                      onSaved: (String value) {
                                        current_pass_c.text = value;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextFormField(
                                      controller: new_pass_c,
                                      keyboardType: TextInputType.text,
                                      obscureText: _showPassword2,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: mainColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showPassword2 = !_showPassword2;
                                            });
                                          },
                                          child: Icon(
                                              _showPassword2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: mainColor),
                                        ),
                                        labelText: 'New Password',
                                        labelStyle: TextStyle(
                                          color: mainColor,
                                          fontSize: MediaQuery.of(context)
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
                                        new_pass_c.text = value;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 15),
                                    child: TextFormField(
                                      controller: confirm_pass_c,
                                      keyboardType: TextInputType.text,
                                      obscureText: _showPassword3,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: mainColor,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showPassword3 = !_showPassword3;
                                            });
                                          },
                                          child: Icon(
                                              _showPassword3
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: mainColor),
                                        ),
                                        labelText: 'Confirm new Password',
                                        labelStyle: TextStyle(
                                          color: mainColor,
                                          fontSize: MediaQuery.of(context)
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
                                        if (value != new_pass_c.text) {
                                          return 'Check your password';
                                        }
                                      },
                                      onSaved: (String value) {
                                        confirm_pass_c.text = value;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 1 *
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20),
                                        width: 6 *
                                            (MediaQuery.of(context).size.width /
                                                10),
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          color: mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30)),
                                          ),
                                          onPressed: () async {
                                            Get.to(Loading());
                                            checkcurrentpassword =
                                                await _authController
                                                    .checkcurrentpassword(
                                                        current_pass_c.text);
                                            setState(() {});
                                            if (!formkey.currentState
                                                .validate()) {
                                              Get.back();
                                              return;
                                            }
                                            if (!checkcurrentpassword) {
                                              Get.back();
                                            }
                                            if (formkey.currentState
                                                    .validate() &&
                                                checkcurrentpassword) {
                                              _authController
                                                  .updateuserpassword(
                                                      new_pass_c.text);
                                              formkey.currentState.save();
                                            }
                                          },
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
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20),
                                        width: 6 *
                                            (MediaQuery.of(context).size.width /
                                                10),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          color: mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30)),
                                          ),
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            "Cancel",
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
