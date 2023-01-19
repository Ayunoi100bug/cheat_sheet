import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateCollection {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '');

  Future<void> createUserCollection(String argUsername, String argEmail, String argUid) async {
    await _firestoreDb.collection("users").doc(argUid).set({
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': myUser.profileImage.toString().trim(),
      'follower': myUser.follower,
      'following': myUser.following,
    });
  }
}