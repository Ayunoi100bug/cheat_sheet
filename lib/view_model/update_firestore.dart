import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../res/components/popup_auth.dart';

class UpdateCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  AuthService myAuth = AuthService();
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetCoverImage: '', demoPages: [], sheetTypeFree: true, authorId: '');

  Future<void> updateUserData() async {
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    if (currentUserSnapshot.exists) {
      await _firestore.collection("users").doc(currentUserData['uid']).set({
        'timestamp': myUser.timestamp,
        'lastDayLogin': myUser.lastDayLogin,
        'username': currentUserData.containsKey('username') ? currentUserData['username'] : myUser.username,
        'email': currentUserData.containsKey('email') ? currentUserData['email'] : myUser.email,
        'uid': currentUserData.containsKey('uid') ? currentUserData['uid'] : myUser.uid,
        'profileImage': currentUserData.containsKey('profileImage') ? currentUserData['profileImage'] : myUser.profileImage,
        'follower': currentUserData.containsKey('follower') ? currentUserData['follower'] : myUser.follower,
        'following': currentUserData.containsKey('following') ? currentUserData['following'] : myUser.following,
        'coin': currentUserData.containsKey('coin') ? currentUserData['coin'] : myUser.coin,
        'trackingAsk': currentUserData.containsKey('trackingAsk') ? currentUserData['trackingAsk'] : myUser.trackingAsk,
        'trackingBuySheet': currentUserData.containsKey('trackingBuySheet') ? currentUserData['trackingBuySheet'] : myUser.trackingBuySheet,
        'trackingCreateSheetList':
            currentUserData.containsKey('trackingCreateSheetList') ? currentUserData['trackingCreateSheetList'] : myUser.trackingCreateSheetList,
        'trackingLike': currentUserData.containsKey('trackingLike') ? currentUserData['trackingLike'] : myUser.trackingLike,
        'trackingLogin': currentUserData.containsKey('trackingLogin') ? currentUserData['trackingLogin'] : myUser.trackingLogin,
        'trackingReadSheet': currentUserData.containsKey('trackingReadSheet') ? currentUserData['trackingReadSheet'] : myUser.trackingReadSheet,
        'trackingReview': currentUserData.containsKey('trackingReview') ? currentUserData['trackingReview'] : myUser.trackingReview,
        'sheetLists': currentUserData.containsKey('sheetLists') ? currentUserData['sheetLists'] : myUser.sheetLists,
        'buyedSheet': currentUserData.containsKey('buyedSheet') ? currentUserData['buyedSheet'] : myUser.buyedSheet,
      }, SetOptions(merge: true));
    }
  }

  Future<void> userBuySheet(BuildContext context, String sid, String authorId, int sheetPrice) async {
    if (!myAuth.isLogged() && sheetPrice > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Popup_Login(context),
      );
      return;
    }
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    var authorSnapshot = await _firestore.collection("users").doc(authorId).get();
    Map<String, dynamic> authorData = authorSnapshot.data()!;
    var buyerSnapshot = await _firestore.collection("users").where("buyedSheet", arrayContains: sid).get();
    int buyerAmount = buyerSnapshot.docs.length;
    if ((sheetPrice == 0 || currentUserData['uid'] == authorId || currentUserData['buyedSheet'].contains(sid))) {
      return;
    } else if (currentUserData['coin'] < sheetPrice && context.mounted) {
      const String message = 'ยอดเงินคงเหลือไม่เพียงพอ';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return;
    }
    await Future.delayed(const Duration(milliseconds: 300), () {
      if (context.mounted) {
        const String message = 'ซื้อชีทสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      }
    });
    /** 
     * * Future.wait ไว้ใช้สำหรับรอให้ตัวที่อยู่ด้านในทำงานเสร็จทุกตัวก่อน ถึงค่อยทำบรรทัดถัดไป
     * TODO: สิ่งที่ต้องปรับหลังแก้ context คือเอา Flushbar ไปไว้ด้านล่างแทน ที่เอามาไว้ด้านบนแบบนี้คือแก้ขัดเฉยๆ
    */
    await Future.wait([
      _firestore.collection("users").doc(currentUserData['uid']).update({
        'timestamp': myUser.timestamp,
        'coin': (currentUserData['coin'] - sheetPrice),
        'buyedSheet': FieldValue.arrayUnion([sid]),
      }),
      _firestore.collection("users").doc(authorId).update({
        'timestamp': myUser.timestamp,
        'coin': (authorData['coin'] + sheetPrice),
      }),
      _firestore.collection("sheet").doc(sid).update({
        'timestamp': mySheet.timestamp,
        'buyer': buyerAmount + 1,
      }),
    ]);
  }

  Future<void> userTopup(BuildContext context, int recieve) async {
    if (!myAuth.isLogged()) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Popup_Login(context),
      );
      return;
    }
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    await _firestore.collection("users").doc(currentUserData['uid']).update({
      'timestamp': myUser.timestamp,
      'coin': (currentUserData['coin'] + recieve),
    }).then((value) {
      String message = 'ได้รับ $recieve เหรียญ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> achievement(BuildContext context, String type) async {
    var achievementSnapshotTracking = await _firestore.collection("achievement").where('type', isEqualTo: type).get();
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    int tracking = currentUserData[type][0];
    await _firestore.collection("users").doc(currentUserData['uid']).update({
      type: [tracking + 1, currentUserData[type][1], currentUserData[type][2], false],
    });
    if (tracking + 1 == currentUserData[type][1]) {
      if (tracking + 1 == 80) {
        await _firestore.collection("users").doc(currentUserData['uid']).update({
          'coin': currentUserData['coin'] + currentUserData[type][2],
          type: [tracking + 1, currentUserData[type][1], currentUserData[type][2], true],
        }).then((value) {
          String message =
              'คุณทำความสำเร็จ ${achievementSnapshotTracking.docs[0]['achievementName']} ${currentUserData[type][1]} ${achievementSnapshotTracking.docs[0]['achievementLastName']} เสร็จสิ้น!';
          FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
        });
      } else {
        await _firestore.collection("users").doc(currentUserData['uid']).update({
          'coin': currentUserData['coin'] + currentUserData[type][2],
          type: [tracking + 1, currentUserData[type][1] * 2, currentUserData[type][2] * 2, false],
        }).then((value) {
          String message =
              'คุณทำความสำเร็จ ${achievementSnapshotTracking.docs[0]['achievementName']} ${currentUserData[type][1]} ${achievementSnapshotTracking.docs[0]['achievementLastName']} เสร็จสิ้น!';
          FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
        });
      }
    }
  }

  Future<void> updateUserDay(BuildContext context, DateTime thisDay, String? userId) async {
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    if (currentUserData['lastDayLogin'].toDate().day != thisDay.day) {
      achievement(context, 'trackingLogin');
    }
    await _firestore.collection("users").doc(userId).update({
      'lastDayLogin': thisDay,
    });
  }
}

class EditProfileData {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  String? urlImage;

  Future<void> uploadImage(File? pickedImage) async {
    if (pickedImage != null) {
      Reference ref = _storage.ref().child('/users/${_auth.currentUser?.uid}/images').child('profileImage');
      await ref.putFile(pickedImage);

      urlImage = await ref.getDownloadURL();
      await _firestore.collection("users").doc(_auth.currentUser?.uid).update({'profileImage': urlImage});
    }
    return;
  }

  Future<void> editUserName(BuildContext context, String currentUid, String newUsername) async {
    await _firestore.collection('users').doc(currentUid).update({
      'username': newUsername,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'เปลี่ยนข้อมูลสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }
}

class UpdateSheetListData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editSheetList(BuildContext context, String currentSheetListId, String newText) async {
    await _firestore.collection('sheetList').doc(currentSheetListId).update({
      'sheetListName': newText,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'เปลี่ยนข้อมูลสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }

  Future<void> updateSheetList(BuildContext context, String currentSheetListId, String currentSheetId) async {
    var currentSheetListSnapshot = await _firestore.collection("sheetList").doc(currentSheetListId).get();
    Map<String, dynamic> currentSheetListData = currentSheetListSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(currentSheetId).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    if (currentSheetListData['sheetListCoverImage'] == '') {
      await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': currentSheetData['sheetCoverImage']});
    }
    await _firestore.collection('sheetList').doc(currentSheetListId).update({
      'sid': FieldValue.arrayUnion([currentSheetId])
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();

      const String message = 'เพิ่มชีทเข้าชีทลิสต์สำเร็จ!';
      FlushbarPopup.successFlushbar(
          context,
          const Icon(
            FontAwesomeIcons.book,
            color: AppColors.white,
          ),
          message);
    });
  }

  Future<void> removeSheetFromList(BuildContext context, String currentSheetListId, String currentSheetId) async {
    await _firestore.collection('sheetList').doc(currentSheetListId).update({
      'sid': FieldValue.arrayRemove([currentSheetId])
    });
    var currentSheetListSnapshot = await _firestore.collection("sheetList").doc(currentSheetListId).get();
    Map<String, dynamic> currentSheetListData = currentSheetListSnapshot.data()!;
    List? sheet = currentSheetListData['sid'];
    if (sheet!.isEmpty) {
      await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': ''});
      return;
    }
    var sheetSnapshot = await _firestore.collection("sheet").doc(currentSheetListData['sid'][0]).get();
    Map<String, dynamic> sheetData = sheetSnapshot.data()!;
    await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': sheetData['sheetCoverImage']});
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();

      const String message = 'ลบชีทออกจากชีทลิสต์สำเร็จ!';
      FlushbarPopup.successFlushbar(
          context,
          const Icon(
            FontAwesomeIcons.book,
            color: AppColors.white,
          ),
          message);
    });
  }
}

class EditReviewData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editReview(BuildContext context, String currentRid, String newTextReview, double newRating) async {
    var currentReviewSnapshot = await _firestore.collection("review").doc(currentRid).get();
    Map<String, dynamic> currentReviewData = currentReviewSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(currentReviewData['sheetId']).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    double result = (currentSheetData['rating'] * reviewInSheet.length) - currentReviewData['rating'];
    await _firestore.collection('review').doc(currentRid).update({
      'text': newTextReview,
      'rating': newRating,
    });
    var newReviewSnapshot = await _firestore.collection("review").doc(currentRid).get();
    Map<String, dynamic> newReviewData = newReviewSnapshot.data()!;
    result = (result + newReviewData['rating']) / reviewInSheet.length;
    await _firestore.collection('sheet').doc(currentReviewData['sheetId']).update({
      'rating': result,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'แก้ไขรีวิวสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }
}

class EditQuestionData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editQuestion(BuildContext context, String currentQid, String newTextQuestion) async {
    var currentQuestionSnapshot = await _firestore.collection("question").doc(currentQid).get();
    Map<String, dynamic> currentQuestionData = currentQuestionSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(currentQuestionData['sheetId']).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    List? questionInSheet = currentSheetData['question'];
    questionInSheet ??= [];
    await _firestore.collection('question').doc(currentQid).update({
      'text': newTextQuestion,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'แก้ไขคำถามสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }
}

class EditAnswerData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editAnswer(BuildContext context, String answerId, String newTextAnswer) async {
    await _firestore.collection('answer').doc(answerId).update({
      'text': newTextAnswer,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'แก้ไขคำตอบสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }
}

class EditSheetData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editSheet(BuildContext context, String currentSid, String newName, String newDetail) async {
    await _firestore.collection('sheet').doc(currentSid).update({
      'sheetName': newName,
      'detailSheet': newDetail,
    }).then(
      (value) => Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'เปลี่ยนรายละเอียดชีทสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      }),
    );
  }
}
