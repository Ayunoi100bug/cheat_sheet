import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ReadCollection {
  final CollectionReference _users = FirebaseFirestore.instance.collection("users");
  final CollectionReference _sheets = FirebaseFirestore.instance.collection("sheet");
  final _auth = FirebaseAuth.instance;

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

  Future<List<String>> getAllSheetExceptCurrentUserWithoutLiked() async {
    var userLikedSheetRef = _firestore
        .collection("sheetList")
        .where("authorId", isEqualTo: _auth.currentUser?.uid)
        .where("sheetListName", isEqualTo: "ชีทที่ถูกใจ")
        .get();
    var userLikedSheetSnapshot = await userLikedSheetRef;
    var userLikedSheetData = userLikedSheetSnapshot.docs[0].data();
    var likedSheetIds = List<String>.from(userLikedSheetData['sid']);

    var sheetRef = _firestore.collection("sheet").where("authorId", isNotEqualTo: _auth.currentUser?.uid);
    var sheetSnapshot = await sheetRef.get();

    // Remove liked sheet IDs from the sheet snapshot
    var remainingSheetDocs = sheetSnapshot.docs.where((doc) => !likedSheetIds.contains(doc.id)).toList();
    var remainingSheetIds = remainingSheetDocs.map((doc) => doc.id).toList();

    return remainingSheetIds;
  }
}
