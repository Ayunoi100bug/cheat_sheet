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

  Future<Map<String, dynamic>> getParamsSheetDataBatch(List<dynamic> argSidList) async {
    var currentArgSheetSnapshot = await _firestore.collection("sheet").where(FieldPath.documentId, whereIn: argSidList).get();
    Map<String, dynamic> currentSheetData = {};
    for (var i = 0; i < currentArgSheetSnapshot.docs.length; i++) {
      currentSheetData[currentArgSheetSnapshot.docs[i].id] = currentArgSheetSnapshot.docs[i].data();
    }

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
    // tag is ordered as follows: คณิตศาสตร์, พระพุทธศาสนา, ภาษาอังกฤษ, ภาษาไทย, วิทยาศาสตร์, สังคมศึกษา
    List<int> allTagCount = [0, 0, 0, 0, 0, 0];
    var allUserLikedSheet = await ReadSheetListCollection().getCurrentUserLikedSheetList();
    if (allUserLikedSheet['sid'].isEmpty) {
      debugPrint("User has no liked sheet");
      return allTagCount;
    }
    List<dynamic> allSheetTags = [];

    Map<String, dynamic> allSheetData = await getParamsSheetDataBatch(allUserLikedSheet['sid']);
    // add all tag from each of sid in allUserLikedSheet into allSheetTags list
    for (var sid in allUserLikedSheet['sid']) {
      if (!allSheetData[sid].containsKey('sheetTags')) continue;
      allSheetTags.addAll(allSheetData[sid]['sheetTags']);
    }

    for (var tagName in allSheetTags) {
      switch (tagName) {
        case "คณิตศาสตร์":
          allTagCount[0]++;
          break;
        case "พระพุทธศาสนา":
          allTagCount[1]++;
          break;
        case "ภาษาอังกฤษ":
          allTagCount[2]++;
          break;
        case "ภาษาไทย":
          allTagCount[3]++;
          break;
        case "วิทยาศาสตร์":
          allTagCount[4]++;
          break;
        case "สังคมศึกษา":
          allTagCount[5]++;
          break;
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
