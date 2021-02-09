import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_login/controllers/authController.dart';
import 'package:phone_login/models/maincolor.dart';
import 'package:phone_login/widgets/loading.dart';

class RecoverPassword extends GetWidget<AuthController> {
  final TextEditingController email_c = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: mainColor,
            body: SingleChildScrollView(
                child: Stack(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70),
                        child: Image(
                            image: AssetImage("assets/ICON.png"),
                            width: MediaQuery.of(context).size.height * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1))
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      child: Form(
                        key: formkey,
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
                                    "Reset Password",
                                    style: TextStyle(
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
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: email_c,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: mainColor,
                                      ),
                                      labelText: 'Registered E-mail'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    } else
                                      return null;
                                  },
                                  onSaved: (String value) {
                                    email_c.text = value;
                                  },
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
                                        if (!formkey.currentState.validate()) {
                                          Get.back();
                                          return;
                                        }
                                        controller.sendpasswordresetemail(
                                            email_c.text);
                                      },
                                      child: Text(
                                        "Get Link",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
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
                                    child: RaisedButton(
                                      elevation: 5.0,
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
                                        "Cancel",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
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
                            ],
                          ),
                        ),
                      ))
                ])
              ])
            ]))));
  }
}
