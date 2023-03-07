import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/image_api.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
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
    double result = 0;
    var currentReviewSnapshot = await _firestore.collection("review").doc(reviewId).get();
    Map<String, dynamic> currentReviewData = currentReviewSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(sheetId).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    result = ((currentSheetData['rating'] * reviewInSheet.length) - currentReviewData['rating']) / (reviewInSheet.length - 1);
    await _firestore.collection('sheet').doc(sheetId).update({
      'review': FieldValue.arrayRemove([reviewId])
    });
    await _firestore.collection('sheet').doc(sheetId).update({'rating': result.isNaN ? 0.toDouble() : result});
    _firestore.collection("review").doc(reviewId).delete().then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'ลบความคิดเห็นสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> deleteSheetList(BuildContext context, String sheetListId) async {
    await _firestore.collection("sheetList").doc(sheetListId).delete();
  }

  Future<void> deleteQuestion(BuildContext context, String questionId, String sheetId) async {
    var currentReviewSnapshot = await _firestore.collection("question").doc(questionId).get();
    Map<String, dynamic> currentReviewData = currentReviewSnapshot.data()!;
    var currentSheetSnapshot = await _firestore.collection("sheet").doc(sheetId).get();
    Map<String, dynamic> currentSheetData = currentSheetSnapshot.data()!;
    List? questionInSheet = currentSheetData['question'];
    questionInSheet ??= [];
    await _firestore.collection('sheet').doc(sheetId).update({
      'question': FieldValue.arrayRemove([questionId])
    });
    await _firestore.collection("question").doc(questionId).delete().then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'ลบความคิดเห็นสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> deleteSheet(BuildContext context, String sheetId) async {
    Navigator.pop(context);
    AutoRouter.of(context).navigateNamed('/home/');

    await Future.delayed(const Duration(milliseconds: 500), () {});
    await _firestore.collection('sheet').doc(sheetId).delete();
    await _firestore.collection('review').where('sheetId', isEqualTo: sheetId).get().then((value) {
      value.docs.forEach((review) {
        _firestore.collection('review').doc(review.id).delete();
      });
    });
    await PDFApi.deleteSheet(sheetId);
    await _firestore.collection('question').where('sheetId', isEqualTo: sheetId).get().then((value) {
      value.docs.forEach((question) async {
        _firestore.collection('question').doc(question.id).delete();
        await ImageApi.deleteQuestionImage(question.id);
      });
    });

    await _firestore.collection('sheetList').get().then((value) {
      value.docs.forEach((list) async {
        await _firestore.collection('sheetList').doc(list.id).update({
          'sid': FieldValue.arrayRemove([sheetId])
        });
      });
    });

    await _firestore.collection('users').get().then((value) {
      value.docs.forEach((user) async {
        await _firestore.collection('users').doc(user.id).update({
          'buyedSheet': FieldValue.arrayRemove([sheetId])
        });
      });
    });
  }
}
