import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/view_model/read_firestore.dart';
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
    var currentUserData = await ReadCollection().getCurrentUserData();
    if (currentUserData.isNotEmpty) {
      Map<String, dynamic> updatedUserData = {};
      if (!currentUserData.containsKey('username')) updatedUserData['username'] = myUser.username;
      if (!currentUserData.containsKey('email')) updatedUserData['email'] = myUser.email;
      if (!currentUserData.containsKey('uid')) updatedUserData['uid'] = myUser.uid;
      if (!currentUserData.containsKey('profileImage')) updatedUserData['profileImage'] = myUser.profileImage;
      if (!currentUserData.containsKey('follower')) updatedUserData['follower'] = myUser.follower;
      if (!currentUserData.containsKey('following')) updatedUserData['following'] = myUser.following;
      if (!currentUserData.containsKey('coin')) updatedUserData['coin'] = myUser.coin;
      if (!currentUserData.containsKey('sheetLists')) updatedUserData['sheetLists'] = myUser.sheetLists;
      if (!currentUserData.containsKey('buyedSheet')) updatedUserData['buyedSheet'] = myUser.buyedSheet;
      if (!currentUserData.containsKey('quest1')) updatedUserData['quest1'] = myUser.quest1;
      if (!currentUserData.containsKey('quest2')) updatedUserData['quest2'] = myUser.quest2;
      if (!currentUserData.containsKey('quest3')) updatedUserData['quest3'] = myUser.quest3;
      if (!currentUserData.containsKey('trackingAsk')) updatedUserData['trackingAsk'] = myUser.trackingAsk;
      if (!currentUserData.containsKey('trackingBuySheet')) updatedUserData['trackingBuySheet'] = myUser.trackingBuySheet;
      if (!currentUserData.containsKey('trackingCreateSheetList')) updatedUserData['trackingCreateSheetList'] = myUser.trackingCreateSheetList;
      if (!currentUserData.containsKey('trackingLike')) updatedUserData['trackingLike'] = myUser.trackingLike;
      if (!currentUserData.containsKey('trackingLogin')) updatedUserData['trackingLogin'] = myUser.trackingLogin;
      if (!currentUserData.containsKey('trackingReadSheet')) updatedUserData['trackingReadSheet'] = myUser.trackingReadSheet;
      if (!currentUserData.containsKey('trackingReview')) updatedUserData['trackingReview'] = myUser.trackingReview;

      if (updatedUserData.isNotEmpty) {
        updatedUserData['timestamp'] = myUser.timestamp;
        await _firestore.collection("users").doc(currentUserData['uid']).set(updatedUserData, SetOptions(merge: true));
        debugPrint("Update user data successfully!");
      }
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
    var currentUserData = await ReadCollection().getCurrentUserData();
    var authorData = await ReadCollection().getParamsUserData(authorId);
    var sheetData = await ReadCollection().getParamsSheetData(sid);
    int buyerAmount = await ReadCollection().getBuyerAmountInSheet(sid);
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
      _firestore
          .collection("sheetList")
          .where('authorId', isEqualTo: currentUserData['uid'])
          .where('sheetListName', isEqualTo: 'ชีทที่ซื้อ')
          .get()
          .then((value) {
        for (var buyedSheetList in value.docs) {
          _firestore.collection("sheetList").doc(buyedSheetList.id).update({
            'sid': FieldValue.arrayUnion([sid]),
            'sheetListCoverImage': (buyedSheetList['sid'].isEmpty) ? sheetData['sheetCoverImage'] : buyedSheetList['sheetListCoverImage'],
          });
        }
      }),
    ]).then((value) async {
      await Future.wait([
        achievement(context, 'trackingBuySheet'),
        quest(context, 'trackingDailyBuySheet'),
      ]);
    });
  }

  Future<void> userTopup(BuildContext context, int recieve) async {
    if (!myAuth.isLogged()) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Popup_Login(context),
      );
      return;
    }
    var currentUserData = await ReadCollection().getCurrentUserData();
    await _firestore.collection("users").doc(currentUserData['uid']).update({
      'timestamp': myUser.timestamp,
      'coin': (currentUserData['coin'] + recieve),
    }).then((value) {
      String message = 'ได้รับ $recieve เหรียญ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }

  // ! Method นี้บัคบ่อย ควรหาเวลาแก้
  Future<void> achievement(BuildContext context, String type) async {
    var achievementSnapshotTracking = await _firestore.collection("achievement").where('type', isEqualTo: type).get();
    var currentUserData = await ReadCollection().getCurrentUserData();
    int tracking = currentUserData[type][0];
    if (currentUserData[type][3] != true) {
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
  }

  Future<void> quest(BuildContext context, String type) async {
    var questSnapshotTracking = await _firestore.collection("dailyQuest").where('type', isEqualTo: type).get();
    var currentUserData = await ReadCollection().getCurrentUserData();
    for (int i = 0; i < 3; i++) {
      if (currentUserData['quest${i + 1}'][2] != true) {
        if (currentUserData['quest${i + 1}'][1] == questSnapshotTracking.docs[0]['id']) {
          int tracking = currentUserData['quest${i + 1}'][0];
          if (tracking + 1 == questSnapshotTracking.docs[0]['complete']) {
            await _firestore.collection("users").doc(currentUserData['uid']).update({
              'quest${i + 1}': [tracking + 1, currentUserData['quest${i + 1}'][1], true],
              'coin': currentUserData['coin'] + questSnapshotTracking.docs[0]['point'],
            }).then((value) {
              String message = 'คุณทำเควสรายวัน ${questSnapshotTracking.docs[0]['questName']} เสร็จสิ้น!';
              FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
            });
          } else {
            await _firestore.collection("users").doc(currentUserData['uid']).update({
              'quest${i + 1}': [tracking + 1, currentUserData['quest${i + 1}'][1], false],
            });
          }
        }
      }
    }
  }

  Future<void> updateUserDay(BuildContext context, DateTime thisDay, String? userId) async {
    var currentUserData = await ReadCollection().getCurrentUserData();
    if (currentUserData['lastDayLogin'].toDate().day != thisDay.day) {
      achievement(context, 'trackingLogin');
      updateQuest();
    }
    await _firestore.collection("users").doc(userId).update({
      'lastDayLogin': thisDay,
    });
  }

  List getRandomNumber(int num) {
    List number = [];
    while (number.length <= 3) {
      int ran = Random().nextInt(num) + 1;
      if (!number.contains(ran)) {
        number.add(ran);
      }
    }
    return number;
  }

  Future<void> updateQuest() async {
    List num = getRandomNumber(5);
    for (int i = 0; i < 3; i++) {
      var currentUserData = await ReadCollection().getCurrentUserData();
      await _firestore.collection("users").doc(currentUserData['uid']).update({
        'quest1': [0, num[0].toString(), false],
        'quest2': [0, num[1].toString(), false],
        'quest3': [0, num[2].toString(), false],
      });
    }
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

  Future<void> like(BuildContext context, String argSid, String argCoverImage) async {
    var sheetListData = await ReadSheetListCollection().getCurrentUserLikedSheetList();
    if (!sheetListData['sid'].contains(argSid)) {
      await _firestore.collection("sheetList").doc(sheetListData['sheetListId']).update({
        'sid': FieldValue.arrayUnion([argSid]),
        'sheetListCoverImage': sheetListData['sheetListCoverImage'] == '' ? argCoverImage : sheetListData['sheetListCoverImage'],
      });
    } else {
      await _firestore.collection("sheetList").doc(sheetListData['sheetListId']).update({
        'sid': FieldValue.arrayRemove([argSid]),
        'sheetListCoverImage': sheetListData['sid'].isEmpty ? sheetListData['sheetListCoverImage'] : '',
      });
    }
  }

  Future<void> editSheetList(BuildContext context, String currentSheetListId, String newText) async {
    await _firestore.collection('sheetList').doc(currentSheetListId).update({
      'sheetListName': newText,
    }).then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'เปลี่ยนข้อมูลสำเร็จ';
      FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> updateSheetList(BuildContext context, String currentSheetListId, String currentSheetId) async {
    var currentSheetListData = await ReadSheetListCollection().getParamsSheetListData(currentSheetListId);
    var currentSheetData = await ReadCollection().getParamsSheetData(currentSheetId);
    if (currentSheetListData['sheetListCoverImage'] == '') {
      await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': currentSheetData['sheetCoverImage']});
    }
    await _firestore.collection('sheetList').doc(currentSheetListId).update({
      'sid': FieldValue.arrayUnion([currentSheetId])
    }).then((value) {
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
    var currentSheetListData = await ReadSheetListCollection().getParamsSheetListData(currentSheetListId);
    List? sheet = currentSheetListData['sid'];
    if (sheet!.isEmpty) {
      await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': ''}).then((value) {
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
      return;
    }
    String sheetId = currentSheetListData['sid'][0];
    var sheetData = await ReadCollection().getParamsSheetData(sheetId);
    await _firestore.collection('sheetList').doc(currentSheetListId).update({'sheetListCoverImage': sheetData['sheetCoverImage']}).then((value) {
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
    var currentReviewData = await ReadReviewCollection().getParamsReviewData(currentRid);
    var currentSheetData = await ReadCollection().getParamsSheetData(currentReviewData['sheetId']);
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    double result = (currentSheetData['rating'] * reviewInSheet.length) - currentReviewData['rating'];
    await _firestore.collection('review').doc(currentRid).update({
      'text': newTextReview,
      'rating': newRating,
    });
    var newReviewData = await ReadReviewCollection().getParamsReviewData(currentRid);
    result = (result + newReviewData['rating']) / reviewInSheet.length;
    await _firestore.collection('sheet').doc(currentReviewData['sheetId']).update({
      'rating': result,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'แก้ไขรีวิวสำเร็จ';
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, message);
      });
    });
  }
}

class EditQuestionData {
  final _firestore = FirebaseFirestore.instance;

  Future<void> editQuestion(BuildContext context, String currentQid, String newTextQuestion) async {
    var currentQuestionData = await ReadQuestionCollection().getParamsQuestionData(currentQid);
    var currentSheetData = await ReadCollection().getParamsSheetData(currentQuestionData['sheetId']);
    List? questionInSheet = currentSheetData['question'];
    questionInSheet ??= [];
    await _firestore.collection('question').doc(currentQid).update({
      'text': newTextQuestion,
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AutoRouter.of(context).popUntilRoot();
        const String message = 'แก้ไขคำถามสำเร็จ';
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, message);
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
        AutoRouter.of(context).popUntilRouteWithName('DetailSheetRoute');
        const String message = 'เปลี่ยนรายละเอียดชีทสำเร็จ';
        FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
      }),
    );
  }
}

class FollowSystem {
  final _firestore = FirebaseFirestore.instance;

  Future followUser(String currentUser, String userId) async {
    await _firestore.collection("users").doc(currentUser).update({
      "following": FieldValue.arrayUnion([userId]),
    });
    await _firestore.collection("users").doc(userId).update({
      "follower": FieldValue.arrayUnion([currentUser]),
    });
  }

  Future unfollowUser(String currentUser, String userId) async {
    await _firestore.collection("users").doc(currentUser).update({
      "following": FieldValue.arrayRemove([userId]),
    });
    await _firestore.collection("users").doc(userId).update({
      "follower": FieldValue.arrayRemove([currentUser]),
    });
  }
}
