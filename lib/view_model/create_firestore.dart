import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/answer.dart';
import 'package:cheat_sheet/model/question.dart';
import 'package:cheat_sheet/model/review.dart';
import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/sheet_list.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/view_model/read_firestore.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uuid/uuid.dart';

import '../res/components/flushbar.dart';
import '../res/components/flushbar_icon.dart';

class CreateCollection {
  final storageRef = FirebaseStorage.instance.ref();
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetCoverImage: '', demoPages: [], sheetTypeFree: true, authorId: '');
  SheetLists mySheetLists = SheetLists(sheetListName: '', sid: [], authorId: '', sheetListId: '');
  Reviews myReview = Reviews(text: '', rid: '', reviewerId: '', sheetId: '', rating: 0, like: 0);
  Question myQuestion = Question(text: '', sheetId: '', questionerId: '', askingPage: 0, like: 0, dislike: 0);
  AnswerModel myAnswer = AnswerModel(text: '', respondentId: '', like: 0);

  Future<void> createUserCollection(String argUsername, String argEmail, String argUid) async {
    const String defaultPath = "images/default_profile.png";
    final Reference storageRef = _storage.ref().child(defaultPath);
    final String url = await storageRef.getDownloadURL();
    await _firestore.collection("users").doc(argUid).set({
      'timestamp': myUser.timestamp,
      'lastDayLogin': myUser.lastDayLogin,
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': url,
      'follower': myUser.follower,
      'following': myUser.following,
      'coin': myUser.coin,
      'quest1': myUser.quest1,
      'quest2': myUser.quest2,
      'quest3': myUser.quest3,
      'trackingAsk': myUser.trackingAsk,
      'trackingBuySheet': myUser.trackingBuySheet,
      'trackingCreateSheetList': myUser.trackingCreateSheetList,
      'trackingLike': myUser.trackingLike,
      'trackingLogin': myUser.trackingLogin,
      'trackingReadSheet': myUser.trackingReadSheet,
      'trackingReview': myUser.trackingReview,
      'sheetLists': myUser.sheetLists,
      'buyedSheet': myUser.buyedSheet,
    });
    await createBuyedAndLikedSheetList(argUid);
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
        'lastDayLogin': myUser.lastDayLogin,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': currentuser?.photoURL,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'quest1': myUser.quest1,
        'quest2': myUser.quest2,
        'quest3': myUser.quest3,
        'trackingAsk': myUser.trackingAsk,
        'trackingBuySheet': myUser.trackingBuySheet,
        'trackingCreateSheetList': myUser.trackingCreateSheetList,
        'trackingLike': myUser.trackingLike,
        'trackingLogin': myUser.trackingLogin,
        'trackingReadSheet': myUser.trackingReadSheet,
        'trackingReview': myUser.trackingReview,
        'sheetLists': myUser.sheetLists,
        'buyedSheet': myUser.buyedSheet,
      });
      await createBuyedAndLikedSheetList(currentuser!.uid);
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
        'lastDayLogin': myUser.lastDayLogin,
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': profileImage,
        'follower': myUser.follower,
        'following': myUser.following,
        'coin': myUser.coin,
        'quest1': myUser.quest1,
        'quest2': myUser.quest2,
        'quest3': myUser.quest3,
        'trackingAsk': myUser.trackingAsk,
        'trackingBuySheet': myUser.trackingBuySheet,
        'trackingCreateSheetList': myUser.trackingCreateSheetList,
        'trackingLike': myUser.trackingLike,
        'trackingLogin': myUser.trackingLogin,
        'trackingReadSheet': myUser.trackingReadSheet,
        'trackingReview': myUser.trackingReview,
        'sheetLists': myUser.sheetLists,
        'buyedSheet': myUser.buyedSheet,
      });
      await createBuyedAndLikedSheetList(currentuser!.uid);
    }
  }

  Future<void> createSheetCollection(String sheetId, String argSheetName, String argDetailSheet, String urlSheetCoverImage, List<int> demoPages,
      bool argSheetType, int? argPrice, String argAuthorId, List<String> argTagList) async {
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
      'sheetTags': argTagList,
    }).then((value) async {
      await createTag(sheetId, argTagList);
    });
  }

  Future<void> createTag(String argSid, List<String> argTag) async {
    for (String tagDoc in argTag) {
      await _firestore.collection("tag").doc(tagDoc).update({
        'sheetInTagList': FieldValue.arrayUnion([argSid]),
      });
    }
  }

  Future<void> createSheetListCollection(
      BuildContext context, String argSheetListName, List? argSid, String argAuthorId, String argSheetListId, String? argSheetListCoverImage) async {
    await Future.wait([
      _firestore.collection("sheetList").doc(argSheetListId).set({
        'timestamp': mySheetLists.timestamp,
        'sheetListName': argSheetListName.toString().trim(),
        'sid': argSid,
        'authorId': argAuthorId,
        'sheetListId': argSheetListId,
        'sheetListCoverImage': argSheetListCoverImage,
        'accessible': mySheetLists.accessible,
      }),
      _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'sheetLists': FieldValue.arrayUnion([argSheetListId]),
      }),
    ]).then((value) {
      AutoRouter.of(context).popUntilRoot();
      FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, 'สร้างชีทลิสต์สำเร็จ');
    });
  }

  Future<void> createBuyedAndLikedSheetList(String argUid) async {
    String buyedSheetListId = const Uuid().v4();
    String likedSheetListId = const Uuid().v4();
    Map<String, dynamic> likedSheetListData = {
      'timestamp': mySheetLists.timestamp,
      'sheetListName': 'ชีทที่ถูกใจ',
      'sid': [],
      'authorId': argUid,
      'sheetListId': likedSheetListId,
      'sheetListCoverImage': '',
      'accessible': false,
    };
    Map<String, dynamic> buyedSheetListData = Map.from(likedSheetListData);
    buyedSheetListData['sheetListName'] = 'ชีทที่ซื้อ';
    buyedSheetListData['sheetListId'] = buyedSheetListId;
    buyedSheetListData['timestamp'] = mySheetLists.timestamp;
    await Future.wait([
      _firestore.collection('sheetList').doc(buyedSheetListId).set(buyedSheetListData),
      _firestore.collection('sheetList').doc(likedSheetListId).set(likedSheetListData),
      _firestore.collection('users').doc(argUid).update({
        'sheetLists': FieldValue.arrayUnion([buyedSheetListId, likedSheetListId]),
      }),
    ]);
  }

  Future<void> createSheetListAndUpdateCollection(BuildContext context, String argSheetListName, List? argSid, String argAuthorId,
      String argSheetListId, String? argSheetListCoverImage, String sheetId) async {
    await _firestore.collection("sheetList").doc(argSheetListId).set({
      'timestamp': mySheetLists.timestamp,
      'sheetListName': argSheetListName.toString().trim(),
      'sid': argSid,
      'authorId': argAuthorId,
      'sheetListId': argSheetListId,
      'sheetListCoverImage': argSheetListCoverImage,
      'accessible': mySheetLists.accessible,
    }).then((value) async {
      await UpdateSheetListData().updateSheetList(context, argSheetListId, sheetId);
    });
  }

  Future<void> createReviewCollection(String argText, String argRid, String argReviewerId, String argSheetId, double argRating, int argLike,
      BuildContext context, String reviewId) async {
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
    var currentReviewData = await ReadReviewCollection().getParamsReviewData(reviewId);
    var currentSheetData = await ReadCollection().getParamsSheetData(argSheetId);
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    result = ((currentSheetData['rating'] * reviewInSheet.length) + currentReviewData['rating']) / (reviewInSheet.length + 1);
    await Future.wait([
      Future.delayed(const Duration(seconds: 0), () {
        AutoRouter.of(context).popUntilRouteWithName('DetailSheetRoute');
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, 'รีวิวสำเร็จ');
      }),
      _firestore.collection('sheet').doc(argSheetId).update({
        'review': FieldValue.arrayUnion([reviewId])
      }),
      _firestore.collection('sheet').doc(argSheetId).update({'rating': result}),
    ]).then((value) async {
      await Future.wait([
        UpdateCollection().achievement(context, 'trackingReview'),
        UpdateCollection().quest(context, 'trackingDailyReview'),
      ]).then((value) {});
    });
  }

  Future<void> createQuestionCollection(
      String argText, String argQuestionId, String argSheetId, String argQuestionerId, BuildContext context, int argAskingPage) async {
    await Future.wait([
      _firestore.collection("question").doc(argQuestionId).set({
        'timestamp': myQuestion.timestamp,
        'qid': argQuestionId,
        'text': argText.toString().trim(),
        'sheetId': argSheetId,
        'questionerId': argQuestionerId,
        'askingPage': argAskingPage,
        'like': myQuestion.like,
        'dislike': myQuestion.dislike,
        'answer': myQuestion.answer,
      }),
      _firestore.collection('sheet').doc(argSheetId).update({
        'question': FieldValue.arrayUnion([argQuestionId])
      }),
    ]).then((value) async {
      await Future.wait([
        UpdateCollection().achievement(context, 'trackingAsk'),
        UpdateCollection().quest(context, 'trackingDailyAsk'),
      ]).then((value) {
        AutoRouter.of(context).popUntilRouteWithName('AskQuestionRoute');
        const String message = 'สร้างคำถามสำเร็จ!';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.createQuestionIcon, message);
      });
    });
  }

  Future<void> createAnswerCollection(String argText, String argAnswerId, String argRespondentId, String argQuestionId, BuildContext context) async {
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 0), () {
        const String message = 'สร้างการตอบกลับสำเร็จ!';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.createAnswerIcon, message);
      }),
      _firestore.collection("answer").doc(argAnswerId).set({
        'timestamp': myAnswer.timestamp,
        'aid': argAnswerId,
        'text': argText.toString().trim(),
        'respondentId': argRespondentId,
        'like': myAnswer.like,
      }),
      _firestore.collection('question').doc(argQuestionId).update({
        'answer': FieldValue.arrayUnion([argAnswerId])
      }),
    ]);
  }
}

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
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
