import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheat_sheet/view_model/hash_password.dart';
import 'package:uuid/uuid.dart';
class Users {
  String username;
  String email;
  String password;
  String uid;
  String profileImage = "assets/images/default_profile.png";

  Users({required this.username,required this.email,required this.password, required this.uid}) {
    uid = const Uuid().v4();
  }

  Future<void> storeInFirestore() async {
    password = await hashPassword(password);
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'username': username.toString().trim(),
      'email': email.toString().trim(),
      'uid': uid.toString().trim(),
      'profileImage': profileImage.toString().trim()
    });
  }
}