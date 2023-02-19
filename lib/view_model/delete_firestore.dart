import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteCollection {
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteAllSheet(context) async {
    _firestore.collection("sheet").get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("sheet").doc(element.id).delete().then((value) {
          Navigator.pop(context);
          const String message = 'ลบชีททั้งหมดสำเร็จ';
          FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
        });
      });
    });
  }
}
