import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:image/image.dart' as imglib;
import 'package:pdf_render/pdf_render.dart' as renderPdf;

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<File?> pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    final String message = 'กรุณาเลือกไฟล์ประเภท pdf';

    if (result == null) return null;
    final fileNameExtension = extension(result.names[0]!);
    if (fileNameExtension != '.pdf') {
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return null;
    }

    return File(result.paths.first.toString());
  }

  static Future<File> loadPDFFromFirebase(String userId, String sheetId) async {
    final refPDF =
        await firebaseStorage.FirebaseStorage.instance.ref().child('users').child('/' + userId).child('/sheet').child('/' + sheetId + '.pdf');

    final String url = 'users/' + userId + '/sheet/' + sheetId + '.pdf';

    final bytes = await refPDF.getData();

    return _storeFile(url, bytes!);
  }

  static Future<firebaseStorage.UploadTask?> uploadToFirebase(BuildContext context, File? inputFile, String userId, String sheetId) async {
    if (inputFile == null) {
      final String message = 'มีบางอย่างผิดปกติ กรุณาลองอีกครั้ง';
      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, message);
      return null;
    }

    firebaseStorage.UploadTask uploadTask;

    firebaseStorage.Reference ref =
        firebaseStorage.FirebaseStorage.instance.ref().child('users').child('/' + userId).child('/sheet').child('/' + sheetId + '.pdf');

    final metadata = firebaseStorage.SettableMetadata(
      contentType: 'file/pdf',
      customMetadata: {'picked-file-path': inputFile.path},
    );

    uploadTask = ref.putData(await inputFile.readAsBytes(), metadata);

    return Future.value(uploadTask);
  }

  static Future<firebaseStorage.UploadTask?> createCoverSheetImage(String userId, String sheetId) async {
    final File file = await loadPDFFromFirebase(userId, sheetId);

    imglib.Image coverImage = await _getImageFromPdf(file, 1);

    File imageFile = await _imageToFile(coverImage);

    return _uploadCoverImageToFirebase(userId, sheetId, imageFile);
  }

  static Future<String> getCoverImage(String userId, String sheetId) async {
    final coverImage = await firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('users')
        .child('/' + userId)
        .child('/cover_sheet_image')
        .child('/' + sheetId + '.png');

    final String imageUrl = await coverImage.getDownloadURL();

    return imageUrl;
  }

  static Future<File> _storeFile(String url, Uint8List bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> _imageToFile(imglib.Image inputImage) async {
    final dir = await getExternalStorageDirectory();

    File imageFile = new File('${dir!.path}/image.png');
    new File(imageFile.path).writeAsBytes(imglib.encodePng(inputImage));

    return imageFile;
  }

  static Future<imglib.Image> _getImageFromPdf(File inputFile, int pageNumber) async {
    final renderPdf.PdfDocument doc = await renderPdf.PdfDocument.openFile(inputFile.path);
    final int numberAllPages = doc.pageCount;

    if (pageNumber > numberAllPages) {
      throw Exception("Error! the page number exceed total page.");
    }

    var getPage = await doc.getPage(pageNumber);
    var pageImage = await getPage.render();
    var image = await pageImage.createImageDetached();
    var imageBytes = await image.toByteData(format: ImageByteFormat.png);
    var libImage = imglib.decodeImage(imageBytes!.buffer.asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes));

    return libImage!;
  }

  static Future<firebaseStorage.UploadTask> _uploadCoverImageToFirebase(String userId, String sheetId, File coverImage) async {
    firebaseStorage.UploadTask uploadTask;

    firebaseStorage.Reference ref =
        firebaseStorage.FirebaseStorage.instance.ref().child('users').child('/' + userId).child('/cover_sheet_image').child('/' + sheetId + '.png');

    final metadata = firebaseStorage.SettableMetadata(
      contentType: 'file/png',
      customMetadata: {'picked-file-path': coverImage.path},
    );

    uploadTask = ref.putData(await coverImage.readAsBytes(), metadata);

    return Future.value(uploadTask);
  }
}
