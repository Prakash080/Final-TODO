import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/widgets/loading.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController email_c = TextEditingController();
  final TextEditingController pass_c = TextEditingController();
  AuthController _authController = AuthController();
  bool _showPassword1 = true;
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
                            padding: const EdgeInsets.symmetric(vertical: 70),
                            child: Image(
                                image: AssetImage("assets/ICON.png"),
                                width: MediaQuery.of(context).size.height * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1))
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
                                      "Delete Account",
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
                                      top: 15, left: 15, right: 15),
                                  child: TextFormField(
                                    controller: email_c,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: mainColor,
                                      ),
                                      labelText: 'Registered E-mail',
                                      labelStyle: TextStyle(
                                        color: mainColor,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: pass_c,
                                    keyboardType: TextInputType.text,
                                    obscureText: _showPassword1,
                                    decoration: InputDecoration(
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
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: mainColor,
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: mainColor,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
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
                                          Get.to(Loading());
                                          _authController.deleteuseraccount(
                                              email_c.text, pass_c.text);
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
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30)),
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
