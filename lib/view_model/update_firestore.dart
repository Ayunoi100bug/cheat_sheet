import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../res/components/popup_login.dart';

class UpdateCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  AuthService myAuth = AuthService();
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetCoverImage: '', sheetTypeFree: true, authorId: '');


  Future<void> updateUserData() async {
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data()!;
    if (currentUserSnapshot.exists) {
      await _firestore.collection("users").doc(currentUserData['uid']).set({
        'timestamp': myUser.timestamp,
        'username': currentUserData.containsKey('username') ? currentUserData['username'] : myUser.username,
        'email': currentUserData.containsKey('email') ? currentUserData['email'] : myUser.email,
        'uid': currentUserData.containsKey('uid') ? currentUserData['uid'] : myUser.uid,
        'profileImage': currentUserData.containsKey('profileImage') ? currentUserData['profileImage'] : myUser.profileImage,
        'follower': currentUserData.containsKey('follower') ? currentUserData['follower'] : myUser.follower,
        'following': currentUserData.containsKey('following') ? currentUserData['following'] : myUser.following,
        'coin': currentUserData.containsKey('coin') ? currentUserData['coin'] : myUser.coin,
        'sheetLists': currentUserData.containsKey('sheetLists') ? currentUserData['sheetLists'] : myUser.sheetLists,
        'buyedSheet': currentUserData.containsKey('buyedSheet') ? currentUserData['buyedSheet'] : myUser.buyedSheet,
      }, SetOptions(merge: true));
    }
  }

  Future<void> userBuySheet(BuildContext context, String sid, String authorId, int sheetPrice) async {

    if (!myAuth.isLogged()) {
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
    var sheetSnapshot = await _firestore.collection("sheet").doc(sid).get();
    Map<String, dynamic> sheetData = sheetSnapshot.data()!;
    if (currentUserData['uid'] == authorId && context.mounted) {
      return;
    } else if (currentUserData['coin'] < sheetPrice) {
      const String message = 'ยอดเงินคงเหลือไม่เพียงพอ';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return;
    } else if (currentUserData['buyedSheet'].contains(sid)) {
      const String message = 'คุณซื้อชีทนี้ไปแล้ว';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return;
    }
    await _firestore.collection("users").doc(currentUserData['uid']).update({
      'timestamp': myUser.timestamp,
      'coin': (currentUserData['coin'] - sheetPrice),
      'buyedSheet': FieldValue.arrayUnion([sid]),
    });
    await _firestore.collection("users").doc(authorId).update({
      'timestamp': myUser.timestamp,
      'coin': (authorData['coin'] + sheetPrice),
    });
    await _firestore.collection("sheet").doc(sid).update({
      'timestamp': mySheet.timestamp,
      // TODO: ต้องเปลี่ยน buyer จากบวกที่ละ 1 เป็นนับจาก sid ที่เจอใน buyedSheet ของ user แต่เบื้องต้นใช้แบบนี้ก่อน
      'buyer': (sheetData['buyer'] + 1),
    }).then((value) {
      const String message = 'ซื้อชีทสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
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
