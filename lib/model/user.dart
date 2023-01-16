import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheat_sheet/view_model/hash_password.dart';
import 'package:uuid/uuid.dart';
class Users {
  String? username;
  String? email;
  String? password;
  String? uid;

  Users({this.username, this.email, this.password}) {
    uid = const Uuid().v4();
  }

  Future<void> storeInFirestore() async {
    password = await hashPassword(password!);
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'username': username,
      'email': email,
      'uid': uid
    });
  }
}