import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReadCollection {
  final CollectionReference _users = FirebaseFirestore.instance.collection("users");

  Stream<DocumentSnapshot> getUserData() {
    return _users.doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  }
}