import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  AuthService myAuth = AuthService();
  Users myUser =
      Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet =
      Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, authorId: '');

  Future<void> userBuySheet(String sid, String authorId, int sheetPrice) async {
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser?.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    var authorSnapshot = await _firestore.collection("users").doc(authorId).get();
    Map<String, dynamic> authorData = authorSnapshot.data()!;
    if (!myAuth.isLogged()) {
      debugPrint("Login first"); 
      return;
    }
    else {
      if (authorId == currentUserData['uid']) {
        debugPrint("Hey, stop that!");
        return;
      } else if (currentUserData['coin'] < sheetPrice) {
        debugPrint("Insufficient balance");
        return;
      } else if (currentUserData['buyedSheet'].contains(sid)) {
        debugPrint("You already buy it, wanna more?");
        return;
      } else {
        await _firestore.collection("users").doc(currentUserData['uid']).update({
          'timestamp': FieldValue.serverTimestamp(),
          'coin': (currentUserData['coin'] - sheetPrice),
          'buyedSheet': FieldValue.arrayUnion([sid]),
        });
        await _firestore.collection("users").doc(authorId).update({
          'timestamp': FieldValue.serverTimestamp(),
          'coin': (authorData['coin'] + sheetPrice),
          'buyer': (authorData['buyer'] + 1),
        });
      }
    }
  }
}
