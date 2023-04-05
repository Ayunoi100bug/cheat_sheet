import 'package:cheat_sheet/view_model/knn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReadCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getCurrentUserData() async {
    var currentUserSnapshot = await _firestore.collection("users").doc(_auth.currentUser?.uid).get();
    Map<String, dynamic> currentUserData = currentUserSnapshot.data() as Map<String, dynamic>;

    return currentUserData;
  }

  Future<Map<String, dynamic>> getParamsUserData(String argUid) async {
    var currentArgUserSnapshot = await _firestore.collection("users").doc(argUid).get();
    Map<String, dynamic> currentUserData = currentArgUserSnapshot.data() as Map<String, dynamic>;

    return currentUserData;
  }

  Future<Map<String, dynamic>> getParamsSheetData(String argSid) async {
    var currentArgSheetSnapshot = await _firestore.collection("sheet").doc(argSid).get();
    Map<String, dynamic> currentSheetData = currentArgSheetSnapshot.data() as Map<String, dynamic>;

    return currentSheetData;
  }

  Future<int> getBuyerAmountInSheet(String argSid) async {
    var buyerSnapshot = await _firestore.collection("users").where("buyedSheet", arrayContains: argSid).get();
    int buyerAmount = buyerSnapshot.docs.length;

    return buyerAmount;
  }

  // * ให้อาท
  Future<List<String>> getAllSheetExceptCurrentUserWithoutLiked() async {
    var userLikedSheetRef = _firestore
        .collection("sheetList")
        .where("authorId", isEqualTo: _auth.currentUser?.uid)
        .where("sheetListName", isEqualTo: "ชีทที่ถูกใจ")
        .get();
    var userLikedSheetSnapshot = await userLikedSheetRef;
    var userLikedSheetData = userLikedSheetSnapshot.docs[0].data();
    var likedSheetIds = List<String>.from(userLikedSheetData['sid']);

    var sheetRef = _firestore.collection("sheet").where("authorId", isNotEqualTo: _auth.currentUser?.uid);
    var sheetSnapshot = await sheetRef.get();

    // Remove liked sheet IDs from the sheet snapshot
    var remainingSheetDocs = sheetSnapshot.docs.where((doc) => !likedSheetIds.contains(doc.id)).toList();
    var remainingSheetIds = remainingSheetDocs.map((doc) => doc.id).toList();

    return remainingSheetIds;
  }

  Future<List<int>> getAmountOfTagOfUserLikes() async {
    // start stopwatch to monitor execution time
    Stopwatch stopwatch = Stopwatch()..start();
    var allUserLikedSheet = await ReadSheetListCollection().getCurrentUserLikedSheetList();
    // tag is ordered as follows: คณิตศาสตร์, พระพุทธศาสนา, ภาษาอังกฤษ, ภาษาไทย, วิทยาศาสตร์, สังคมศึกษา
    List<int> allTagCount = [0, 0, 0, 0, 0, 0];

    // add all tag from each of sid in allUserLikedSheet into allTag list
    for (var sid in allUserLikedSheet['sid']) {
      var tempSheet = await getParamsSheetData(sid);
      if (!tempSheet.containsKey('sheetTags')) continue;
      for (var tagName in tempSheet['sheetTags']) {
        if (tagName == "คณิตศาสตร์") {
          allTagCount[0]++;
        } else if (tagName == "พระพุทธศาสนา") {
          allTagCount[1]++;
        } else if (tagName == "ภาษาอังกฤษ") {
          allTagCount[2]++;
        } else if (tagName == "ภาษาไทย") {
          allTagCount[3]++;
        } else if (tagName == "วิทยาศาสตร์") {
          allTagCount[4]++;
        } else if (tagName == "สังคมศึกษา") {
          allTagCount[5]++;
        }
      }
    }

    // Stop the stopwatch and print the elapsed time
    stopwatch.stop();
    Duration elapsed = stopwatch.elapsed;
    double milliseconds = elapsed.inMilliseconds.toDouble();
    debugPrint('Execution time: $milliseconds ms');

    return allTagCount;
  }
}

class ReadSheetListCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getParamsSheetListData(String argSheetListId) async {
    var currentArgSheetListSnapshot = await _firestore.collection("sheetList").doc(argSheetListId).get();
    Map<String, dynamic> currentSheetListData = currentArgSheetListSnapshot.data() as Map<String, dynamic>;

    return currentSheetListData;
  }

  Future<Map<String, dynamic>> getCurrentUserLikedSheetList() async {
    var currentUserLikedSheetListSnapshot = await _firestore
        .collection("sheetList")
        .where("authorId", isEqualTo: _auth.currentUser?.uid)
        .where("sheetListName", isEqualTo: "ชีทที่ถูกใจ")
        .get();
    Map<String, dynamic> currentUserLikedSheetListData = currentUserLikedSheetListSnapshot.docs[0].data();

    return currentUserLikedSheetListData;
  }
}

class ReadReviewCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getParamsReviewData(String argReviewId) async {
    var currentArgReviewSnapshot = await _firestore.collection("review").doc(argReviewId).get();
    Map<String, dynamic> currentReviewData = currentArgReviewSnapshot.data() as Map<String, dynamic>;

    return currentReviewData;
  }
}

class ReadQuestionCollection {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getParamsQuestionData(String argQuestionId) async {
    var currentArgQuestionSnapshot = await _firestore.collection("question").doc(argQuestionId).get();
    Map<String, dynamic> currentQuestionData = currentArgQuestionSnapshot.data() as Map<String, dynamic>;

    return currentQuestionData;
  }

  Future<Map<String, dynamic>> getParamsAnswerData(String argAnswerId) async {
    var currentArgAnswerSnapshot = await _firestore.collection("answer").doc(argAnswerId).get();
    Map<String, dynamic> currentAnswerData = currentArgAnswerSnapshot.data() as Map<String, dynamic>;

    return currentAnswerData;
  }
}
