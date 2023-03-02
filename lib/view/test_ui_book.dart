import 'dart:io';

import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/answer.dart';
import 'package:cheat_sheet/view/home_screen/question/ask_question.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

import '../res/colors.dart';
import '../res/components/ask.dart';

import 'package:image/image.dart' as imglib;

class TestUIPage extends StatefulWidget {
  const TestUIPage({super.key});

  @override
  State<TestUIPage> createState() => _TestUIPageState();
}

class _TestUIPageState extends State<TestUIPage> {
  late File file;
  late imglib.Image image;
  late File resultFile;

  void seet() async {
    String sheetId = '31d64616-2753-4e3a-8b01-3cb081be97ad';
    file = await PDFApi.loadPDFFromFirebase(sheetId);
    setState(() {});
  }

  void setImage() async {
    image = await PDFApi.getImageFromPdf(file, 1);
    setState(() {});
  }

  void convertFile() async {
    resultFile = await PDFApi.imageToFile(image);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seet();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              setImage();
              setState(() {});
              print(image);
            },
            child: Text('กดเพื่อแปลง pdf เป็น image')),
        ElevatedButton(
            onPressed: () async {
              convertFile();
              setState(() {});
            },
            child: Text('กดเพื่อแปลงไฟล์')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Scaffold(
                  body: Image.file(resultFile),
                );
              }));
            },
            child: Text('ลองรูป')),
        ElevatedButton(
            onPressed: () async {
              setImage();
              setState(() {});
              convertFile();
              setState(() {});
              print(image);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Scaffold(
                  body: Image.file(resultFile),
                );
              }));
            },
            child: Text('ลองรูป')),
        ElevatedButton(
            onPressed: () async {
              firebaseStorage.UploadTask? task = await PDFApi.createCoverSheetImage('31d64616-2753-4e3a-8b01-3cb081be97ad');
              print(task);
            },
            child: Text('ทดสอบอัพ')),
      ]),
    );
  }
}
