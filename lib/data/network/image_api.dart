import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:painter/painter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageApi {
  static Future<firebaseStorage.UploadTask?> uploadToFirebase(PictureDetails image, String questionId) async {
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

  static Future<File> _storeFile(String url, Uint8List bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> _imageToFile(PictureDetails image) async {
    final dir = await getExternalStorageDirectory();

    final bytes = await image.toPNG();

    File imageFile = new File('${dir!.path}/image.png');
    new File(imageFile.path).writeAsBytes(bytes, flush: true);

    return imageFile;
  }
}
