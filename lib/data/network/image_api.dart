import 'dart:io';

import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:painter/painter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageApi {
  Future<firebaseStorage.UploadTask?> uploadToFirebase(PictureDetails image, String questionId) async {
    final file = await _imageToFile(image);

    firebaseStorage.UploadTask uploadTask;

    firebaseStorage.Reference ref = firebaseStorage.FirebaseStorage.instance.ref().child('questions').child(questionId).child(questionId + '.png');

    final metadata = firebaseStorage.SettableMetadata(
      contentType: 'file/png',
      customMetadata: {'picked-file-path': file.path},
    );

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    return Future.value(uploadTask);
  }

  static Future<File> loadQuestionImage(String questionId) async {
    final refPDF = await firebaseStorage.FirebaseStorage.instance.ref().child('questions').child(questionId).child(questionId + '.png');

    final String url = 'questions/' + questionId + '/' + questionId + '.png';

    final bytes = await refPDF.getData();

    return _storeFile(url, bytes!);
  }

  static Future<void> deleteQuestionImage(String questionId) async {
    firebaseStorage.FirebaseStorage.instance.ref().child('questions').child(questionId).child(questionId + '.png').delete();
  }

  static Future<File> _storeFile(String url, Uint8List bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> _imageToFile(PictureDetails image) async {
    final dir = await getExternalStorageDirectory();
    final bytes = await image.toPNG();

    File imageFile = File('${dir!.path}/image.png');
    await Future.wait([
      File(imageFile.path).writeAsBytes(bytes, flush: true),
    ]);

    return drawImageCorruptHandler(bytes, imageFile);
  }

  Future<File> drawImageCorruptHandler(Uint8List newBytes, File handler) async {
    int handlerSize = await handler.length();
    if (handlerSize != 0) {
      debugPrint("Image size is: $handlerSize, and it's not corrupt.");
      return handler;
    }
    int i = 1;
    while (handlerSize == 0) {
      if (i == 1) debugPrint("Begin fixing...");
      if (handlerSize != 0) {
        debugPrint("Fixing ends with $handlerSize image file size.");
        break;
      }
      await Future.wait([
        File(handler.path).writeAsBytes(newBytes, flush: true),
      ]);
      handlerSize = await handler.length();
      debugPrint("Round $i fixed, new image size is: $handlerSize");
    }

    return handler;
  }
}
