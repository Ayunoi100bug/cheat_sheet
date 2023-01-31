import 'dart:io';
import 'package:cheat_sheet/res/components/popup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
      Popup.showSnackBar(
          context,
          true,
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          message);
      return null;
    }

    return File(result.paths.first.toString());
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
