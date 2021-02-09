import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String photoURL;

  UserModel({this.id, this.name, this.email, this.phone, this.photoURL});

  UserModel.fromSnapShot(DocumentSnapshot userSnapShot) {
    this.id = userSnapShot.id;
    this.name = userSnapShot['name'];
    this.email = userSnapShot['email'];
    this.phone = userSnapShot['phone'];
    this.photoURL = userSnapShot['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photoURl'] = this.photoURL;
    return data;
  }
}
