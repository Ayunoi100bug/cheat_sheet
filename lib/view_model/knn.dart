import 'dart:ffi';
import 'dart:math';

import 'package:cheat_sheet/view_model/read_firestore.dart';

class KNN {
  static List<Data> dataList = []; //List of data class.
  static List<double> similarityList = []; //List of similarity values, receive when calculate cosine similarity.
  static List<int> sortedIndexList = []; //Sorted list of data index.
  static bool isCalculate = false;

  static void addDataTolist(Data inputData) {
    dataList.add(inputData);
  }

  static void caculateSimilarity(Data compareData) {
    if (dataList.isEmpty) {
      return;
    }
    //Insertion sort! (0.0)
    for (int i = 0; i < dataList.length; i++) {
      similarityList.add(MathPack.calculateCosin(compareData.listTag, dataList[i].listTag));
      // print('similar update!');
      // print(similarityList);
      sortedIndexList.add(i);
      // print('index list update!');
      // print(sortedIndexList.length);
      if (sortedIndexList.length > 1) {
        // print('i = ' + i.toString());
        for (int j = i; j > 0; j--) {
          if (similarityList[sortedIndexList[j - 1]] > similarityList[sortedIndexList[j]]) {
            continue;
          }
          // print('j = ' + j.toString());
          // print('insertion sort activate!');
          // print('before ' + sortedIndexList.toString());
          int temp = sortedIndexList[j];
          sortedIndexList[j] = sortedIndexList[j - 1];
          sortedIndexList[j - 1] = temp;
          // print('after ' + sortedIndexList.toString());
        }
      }
    }
    // displayData();
    // displaySimilarity();
    print(sortedIndexList);
    isCalculate = true;
  }

  static void resetKNN() {
    dataList.clear();
    similarityList.clear();
    sortedIndexList.clear();
    isCalculate = false;
  }

  static void displayData() {
    for (int i = 0; i < dataList.length; i++) {
      print("[Data][" + (i + 1).toString() + "] " + dataList[i].listTag.toString());
    }
  }

  static void displaySimilarity() {
    for (int i = 0; i < similarityList.length; i++) {
      print("[Data][" + (i + 1).toString() + "] " + similarityList[i].toString());
    }
  }

  static void loadSheetData() async {
    var sheetId = await ReadCollection().getAllSheetExceptCurrentUserWithoutLiked();
    for (var i = 0; i < sheetId.length; i++) {
      var sheetData = await ReadCollection().getParamsSheetData(sheetId[i]);
      List<dynamic> dynamicTagList = sheetData['sheetTags'] ?? []; // add null check here
      List<String> tagList = dynamicTagList.map((item) => item.toString()).toList();
      Data targetSheet = Data(sheetId: sheetId[i], tagNameList: tagList);
      KNN.addDataTolist(targetSheet);
    }
  }
}

class Data {
  /* Class for convert sheet into another form, for calculation in KNN class */
  String sheetId;
  List<int> listTag = [0, 0, 0, 0, 0, 0]; //update this vector length depends on number of tag

  Data({required this.sheetId, required List<String> tagNameList}) {
    for (int i = 0; i < tagNameList.length; i++) {
      listTag[tagConverter(tagNameList[i])] = 1;
    }
  }

  /*Convert text tag to vector, if you adjust tag in database you should update here too! */
  int tagConverter(String tagName) {
    switch (tagName) {
      case "พระพุทธศาสนา":
        return 1;
      case "ภาษาอังกฤษ":
        return 2;
      case "ภาษาไทย":
        return 3;
      case "วิทยาศาสตร์":
        return 4;
      case "สังคมศึกษา":
        return 5;
      default:
        return 0; //คณิตศาสตร์
    }
  }

  /*for monitoring... */
  void displayList() {
    for (int i = 0; i < listTag.length; i++) {
      print("index[" + i.toString() + "] " + listTag[i].toString());
    }
  }
}

class MathPack {
  /* Class for calculate cosine similarity, mostly you don't use it. */

  static double calculateCosin(List<int> vector1, List<int> vector2) {
    double sum = dotProduct(vector1, vector2);
    double normV1 = norm(vector1);
    double normV2 = norm(vector2);
    if ((normV1 == 0) | (normV2 == 0)) {
      return 0;
    }
    sum = sum / (norm(vector1) * norm(vector2));
    return sum;
  }

  static double dotProduct(List<int> vector1, List<int> vector2) {
    checkVectorsLength(vector1, vector2);
    double sum = 0;
    for (int i = 0; i < vector1.length; i++) {
      sum += vector1[i] * vector2[i];
    }
    return sum;
  }

  static double norm(List<int> vector) {
    double sum = 0;
    for (int i = 0; i < vector.length; i++) {
      sum += vector[i] * vector[i];
    }
    sum = sqrt(sum);
    return sum;
  }

  static void checkVectorsLength(List<int> vector1, List<int> vector2) {
    if (vector1.length != vector2.length) {
      throw 'both vector length are not equal!';
    }
  }
}
