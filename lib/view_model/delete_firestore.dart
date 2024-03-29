import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/image_api.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/view_model/read_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteCollection {
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteAllSheet(context) async {
    await Future.wait([
      _firestore.collection("sheet").get().then((value) async {
        for (var element in value.docs) {
          await _firestore.collection("sheet").doc(element.id).delete();
        }
      }),
      _firestore.collection("sheetList").get().then((value) async {
        for (var element in value.docs) {
          await _firestore.collection("sheetList").doc(element.id).update({
            'sid': FieldValue.arrayRemove(element['sid']),
            'sheetListCoverImage': "",
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }),
      // ฝากลบชีทใน storage ที
    ]).then((value) {
      AutoRouter.of(context).pop();
      const String message = 'ลบชีททั้งหมดสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }
}

class DeleteDocument {
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteReview(BuildContext context, String reviewId, String sheetId) async {
    double result = 0;
    var currentReviewData = await ReadReviewCollection().getParamsReviewData(reviewId);
    var currentSheetData = await ReadCollection().getParamsSheetData(sheetId);
    List? reviewInSheet = currentSheetData['review'];
    reviewInSheet ??= [];
    result = ((currentSheetData['rating'] * reviewInSheet.length) - currentReviewData['rating']) / (reviewInSheet.length - 1);
    await Future.wait([
      _firestore.collection('sheet').doc(sheetId).update({
        'review': FieldValue.arrayRemove([reviewId])
      }),
      _firestore.collection('sheet').doc(sheetId).update({'rating': result.isNaN ? 0.toDouble() : result}),
      _firestore.collection("review").doc(reviewId).delete(),
    ]).then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'ลบความคิดเห็นสำเร็จ';
      FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> deleteSheetList(BuildContext context, String sheetListId) async {
    await _firestore.collection("sheetList").doc(sheetListId).delete();
    // ไม่มี flushbar?
  }

  Future<void> deleteQuestion(BuildContext context, String questionId, String sheetId) async {
    var currentSheetData = await ReadCollection().getParamsSheetData(sheetId);
    List? questionInSheet = currentSheetData['question'];
    questionInSheet ??= [];
    await Future.wait([
      _firestore.collection('sheet').doc(sheetId).update({
        'question': FieldValue.arrayRemove([questionId])
      }),
      _firestore.collection("question").doc(questionId).delete(),
    ]).then((value) {
      AutoRouter.of(context).popUntilRoot();
      const String message = 'ลบคำถามสำเร็จ';
      FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, message);
    });
  }

  Future<void> deleteAnswer(BuildContext context, String answerId, String questionId) async {
    var currentQuestionData = await ReadQuestionCollection().getParamsQuestionData(questionId);
    List? answerInQuestion = currentQuestionData['answer'];
    answerInQuestion ??= [];
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 0), () {
        Navigator.pop(context);
        AutoRouter.of(context).pop();
      }),
      _firestore.collection('question').doc(questionId).update({
        'answer': FieldValue.arrayRemove([answerId])
      }),
      _firestore.collection("answer").doc(answerId).delete(),
    ]);
  }

  Future<void> deleteSheet(BuildContext context, String sheetId) async {
    Navigator.pop(context);
    AutoRouter.of(context).navigateBack();
    FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, 'ลบชีทสำเร็จ');

    await Future.delayed(const Duration(milliseconds: 500), () async {
      await _firestore.collection('tag').where('sheetInTagList', arrayContains: sheetId).get().then((value) async {
        for (var tag in value.docs) {
          await tag.reference.update({
            'sheetInTagList': FieldValue.arrayRemove([sheetId]),
          });
        }
      });
      await _firestore.collection('sheet').doc(sheetId).delete();
      await _firestore.collection('review').where('sheetId', isEqualTo: sheetId).get().then((value) async {
        for (var review in value.docs) {
          await _firestore.collection('review').doc(review.id).delete();
        }
      });
      await PDFApi.deleteSheet(sheetId);
      await _firestore.collection('question').where('sheetId', isEqualTo: sheetId).get().then((value) async {
        for (var question in value.docs) {
          await _firestore.collection('question').doc(question.id).delete();
          await ImageApi.deleteQuestionImage(question.id);
        }
      });
      await _firestore.collection('sheetList').get().then((value) async {
        for (var list in value.docs) {
          await _firestore.collection('sheetList').doc(list.id).update({
            'sid': FieldValue.arrayRemove([sheetId])
          });
        }
      });
      await _firestore.collection('users').get().then((value) async {
        for (var user in value.docs) {
          await _firestore.collection('users').doc(user.id).update({
            'buyedSheet': FieldValue.arrayRemove([sheetId])
          });
        }
      });
    });
  }
}
