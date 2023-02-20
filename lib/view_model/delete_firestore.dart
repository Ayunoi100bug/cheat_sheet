import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class DeleteCollection {
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteAllSheet(context) async {
    _firestore.collection("sheet").get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("sheet").doc(element.id).delete().then((value) {
          AutoRouter.of(context).pop();

          Future.delayed(const Duration(milliseconds: 500), () {
            const String message = 'ลบชีททั้งหมดสำเร็จ';
            FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
          });
        });
      });
    });
  }
}

class DeleteDocument {
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteReview(BuildContext context, String reviewId, String sheetId) async {
    await _firestore.collection('sheet').doc(sheetId).update({
      'review': FieldValue.arrayRemove([reviewId])
    });
    _firestore.collection("review").doc(reviewId).delete().then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'ลบความคิดเห็นสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }
}
