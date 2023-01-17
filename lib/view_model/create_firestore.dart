import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateCollection {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '');

  Future<void> createUserCollection() async {
    await _firestoreDb.collection("users").doc(myUser.uid).set({
      'username': myUser.username.toString().trim(),
      'email': myUser.email.toString().trim(),
      'uid': myUser.uid.toString().trim(),
      'profileImage': myUser.profileImage.toString().trim()
    });
  }
}