import 'dart:io';

import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class CreateCollection {
  final storageRef = FirebaseStorage.instance.ref();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Users myUser =
      Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet =
      Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, authorId: '');

  Future<void> createUserCollection(
      String argUsername, String argEmail, String argUid) async {
    const String defaultPath = "images/default_profile.png";
    final Reference storageRef = _storage.ref().child(defaultPath);
    final String url = await storageRef.getDownloadURL();
    await _firestoreDb.collection("users").doc(argUid).set({
      'timestamp': myUser.timestamp,
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': url,
      'follower': myUser.follower,
      'following': myUser.following,
      'coin': myUser.coin,
      'sheetLists': myUser.sheetLists,
    });
  }

  Future<void> createGoogleUserCollection(User? currentuser) async {
    final userRef = _firestoreDb.collection("users").doc(currentuser?.uid);
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      String? fullName = currentuser?.displayName;
      List<String>? cutName = fullName?.split(" ");
      String? firstName = cutName?[0];
      await _firestoreDb.collection("users").doc(currentuser?.uid).set({
        'timestamp': myUser.timestamp,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': currentuser?.photoURL,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'sheetLists': myUser.sheetLists,
      });
    }
  }

  Future<void> createFacebookUserCollection(User? currentuser) async {
    final userRef = _firestoreDb.collection("users").doc(currentuser?.uid);
    final userData = await FacebookAuth.i.getUserData();
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      String? fullName = currentuser?.displayName;
      List<String>? cutName = fullName?.split(" ");
      String? firstName = cutName?[0];
      String profileImage = userData['picture']['data']['url'];
      await _firestoreDb.collection("users").doc(currentuser?.uid).set({
        'timestamp': myUser.timestamp,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': profileImage,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'sheetLists': myUser.sheetLists,
      });
    }
  }

  Future<void> createSheetCollection(String argSheetName, String argDetailSheet,
      bool argSheetType, int? argPrice, String argAuthorId) async {
    await _firestoreDb.collection("sheet").doc(mySheet.sid).set({
      'timestamp': mySheet.timestamp,
      'sheetName': argSheetName.toString().trim(),
      'detailSheet': argDetailSheet.toString().trim(),
      'sheetTypeFree': argSheetType,
      'price': argPrice,
      'sid': mySheet.sid,
      'authorId': argAuthorId,
    });
  }

  Future<void> createSheetListCollection(String argSheetListName, List? argSid,
      String argAuthorId, String argSheetListId) async {
    await _firestoreDb.collection("sheetList").doc(argSheetListId).set({
      'timestamp': mySheet.timestamp,
      'sheetListName': argSheetListName.toString().trim(),
      'sid': argSid,
      'authorId': argAuthorId,
      'sheetListId': argSheetListId,
    });
  }
}

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseStorage.instance.ref().child('userImages');
  late String imageURL;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await ref.putFile(file);
      imageURL = await ref.getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> ListFile() async {
    firebase_storage.ListResult results = await storage.ref('images').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file : $ref');
    });
    return results;
  }
}
