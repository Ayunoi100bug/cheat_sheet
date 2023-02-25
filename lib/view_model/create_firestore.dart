import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/question.dart';
import 'package:cheat_sheet/model/review.dart';
import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/sheet_list.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../res/components/flushbar.dart';
import '../res/components/flushbar_icon.dart';

class CreateCollection {
  final storageRef = FirebaseStorage.instance.ref();
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetCoverImage: '', demoPages: [], sheetTypeFree: true, authorId: '');
  SheetLists mySheetLists = SheetLists(sheetListName: '', sid: [], authorId: '', sheetListId: '');
  Reviews myReview = Reviews(text: '', rid: '', reviewerId: '', sheetId: '', rating: 0, like: 0);
  Question myQuestion = Question(text: '', sheetId: '', questionerId: '', askingPage: 0);

  Future<void> createUserCollection(String argUsername, String argEmail, String argUid) async {
    const String defaultPath = "images/default_profile.png";
    final Reference storageRef = _storage.ref().child(defaultPath);
    final String url = await storageRef.getDownloadURL();
    await _firestore.collection("users").doc(argUid).set({
      'timestamp': myUser.timestamp,
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': url,
      'follower': myUser.follower,
      'following': myUser.following,
      'coin': myUser.coin,
      'sheetLists': myUser.sheetLists,
      'buyedSheet': myUser.buyedSheet,
    });
  }

  Future<void> createGoogleUserCollection(User? currentuser) async {
    final userRef = _firestore.collection("users").doc(currentuser?.uid);
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      String? fullName = currentuser?.displayName;
      List<String>? cutName = fullName?.split(" ");
      String? firstName = cutName?[0];
      await _firestore.collection("users").doc(currentuser?.uid).set({
        'timestamp': myUser.timestamp,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': currentuser?.photoURL,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'sheetLists': myUser.sheetLists,
        'buyedSheet': myUser.buyedSheet,
      });
    }
  }

  Future<void> createFacebookUserCollection(User? currentuser) async {
    final userRef = _firestore.collection("users").doc(currentuser?.uid);
    final userData = await FacebookAuth.i.getUserData();
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      String? fullName = currentuser?.displayName;
      List<String>? cutName = fullName?.split(" ");
      String? firstName = cutName?[0];
      String profileImage = userData['picture']['data']['url'];
      await _firestore.collection("users").doc(currentuser?.uid).set({
        'timestamp': myUser.timestamp,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': profileImage,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'sheetLists': myUser.sheetLists,
        'buyedSheet': myUser.buyedSheet,
      });
    }
  }

  Future<void> createSheetCollection(String sheetId, String argSheetName, String argDetailSheet, String urlSheetCoverImage, List<int> demoPages,
      bool argSheetType, int? argPrice, String argAuthorId) async {
    await _firestore.collection("sheet").doc(sheetId).set({
      'timestamp': mySheet.timestamp,
      'sheetName': argSheetName.toString().trim(),
      'detailSheet': argDetailSheet.toString().trim(),
      'sheetCoverImage': urlSheetCoverImage,
      'demoPages': demoPages,
      'sheetTypeFree': argSheetType,
      'rating': mySheet.rating,
      'price': argPrice,
      'sid': sheetId,
      'buyer': mySheet.buyer,
      'authorId': argAuthorId,
    });
  }

  Future<void> createSheetListCollection(String argSheetListName, List? argSid, String argAuthorId, String argSheetListId) async {
    await _firestore.collection("sheetList").doc(argSheetListId).set({
      'timestamp': mySheetLists.timestamp,
      'sheetListName': argSheetListName.toString().trim(),
      'sid': argSid,
      'authorId': argAuthorId,
      'sheetListId': argSheetListId,
    });
  }

  Future<void> createReviewCollection(String argText, String argRid, String argReviewerId, String argSheetId, double argRating, int argLike,
      BuildContext context, String _review) async {
    double result = 0;
    if (argRating == 0) {
      const String message = 'กรุณาระบุคะแนนที่ท่านต้องการให้ก่อน!';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return;
    }
    await _firestore.collection("review").doc(argRid).set({
      'timestamp': myReview.timestamp,
      'text': argText.toString().trim(),
      'reviewerId': argReviewerId,
      'sheetId': argSheetId,
      'rating': argRating,
      'rid': argRid,
      'like': argLike,
    });
    var currentReviewSnapshot = await _firestore.collection("review").doc(_review).get();
    Map<String, dynamic> currentReviewData = currentReviewSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(argSheetId).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    result = ((currentSheetData['rating'] * reviewInSheet.length) + currentReviewData['rating']) / (reviewInSheet.length + 1);
    await _firestore.collection('sheet').doc(argSheetId).update({
      'review': FieldValue.arrayUnion([_review])
    });
    await _firestore.collection('sheet').doc(argSheetId).update({'rating': result}).then(
      (value) {
        AutoRouter.of(context).pop();
        const String message = 'รีวิวสำเร็จแล้ว!';
        // FlushbarPopup.successFlushbar(context, const Icon(Icons.reviews), message);
      },
    );
  }

  Future<void> createQuestionCollection(String argText, String argSheetId, String argQuestionerId, BuildContext context, int argAskingPage) async {
    await _firestore.collection("question").doc(myQuestion.qid).set({
      'timestamp': myQuestion.timestamp,
      'qid': myQuestion.qid,
      'text': argText.toString().trim(),
      'sheetId': argSheetId,
      'questionerId': argQuestionerId,
      'askingPage': argAskingPage,
      'like': myQuestion.like,
      'dislike': myQuestion.dislike,
    });
    await _firestore.collection('sheet').doc(argSheetId).update({
      'question': FieldValue.arrayUnion([myQuestion.qid])
    }).then(
      (value) {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'สร้างคำถามสำเร็จ!';
        FlushbarPopup.successFlushbar(context, const Icon(Icons.question_answer), message);
      },
    );
  }
}

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
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
