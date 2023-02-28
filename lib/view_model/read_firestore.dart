import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ReadCollection {
  final CollectionReference _users = FirebaseFirestore.instance.collection("users");
  final CollectionReference _sheets = FirebaseFirestore.instance.collection("sheet");

  final _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUserData() {
    return _users.doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  }

  Future<Map<String, dynamic>> getQuestionData(int index, String sheetId, int askingPage) async {
    var currentQuestionSnapshot =
        await _firestore.collection("question").where('sheetId', isEqualTo: sheetId).where('askingPage', isEqualTo: askingPage).get();
    Map<String, dynamic> currentQuestionData = currentQuestionSnapshot.docs[index].data();
    return currentQuestionData;
  }
}
