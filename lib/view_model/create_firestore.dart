import 'dart:io';

import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CreateCollection {
  final storageRef = FirebaseStorage.instance.ref();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '');
  Sheets mySheet =
      Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, authorId: '');

  Future<void> createUserCollection(
      String argUsername, String argEmail, String argUid) async {
    await _firestoreDb.collection("users").doc(argUid).set({
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': myUser.profileImage.toString().trim(),
      'follower': myUser.follower,
      'following': myUser.following,
    });
  }

  Future<void> createSheetCollection(String argSheetName, String argDetailSheet,
      bool argSheetType, int? argPrice, String argUid) async {
    await _firestoreDb.collection("sheet").doc(mySheet.sid).set({
      'sheetName': argSheetName.toString().trim(),
      'detailSheet': argDetailSheet.toString().trim(),
      'sheetTypeFree': argSheetType,
      'price': argPrice,
      'uid': argUid,
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
