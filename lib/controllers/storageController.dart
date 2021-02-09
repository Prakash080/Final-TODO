import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phone_login/screens/home.dart';
import 'package:phone_login/services/fireDB.dart';

class storageController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadFile(file) async {
    var userID = _auth.currentUser.uid;

    var storageref = storage.ref().child("users/profile/${userID}");
    var uploadtask = await storageref.putFile(file).whenComplete(() {
      Get.to(Home());
      Fluttertoast.showToast(msg: "Profile picture updated successfully");
    });
    String downloadUrl = await uploadtask.ref.getDownloadURL();
    FireDb().updateURL(userID, downloadUrl);
    return downloadUrl;
  }
}
