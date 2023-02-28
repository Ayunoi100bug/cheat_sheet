import 'dart:io';

import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/answer.dart';
import 'package:cheat_sheet/view/home_screen/question/ask_question.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

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
    String sheetId = 'ac171422-beff-4362-a547-14d21654e272';
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
            onPressed: () {
              convertFile();
              setState(() {});
              print(resultFile);
              Builder(
                builder: (context) => Image.file(file),
              );
              setState(() {});
            },
            child: Text('กดเพื่อแปลงไฟล์')),
        Text('data'),
        Text('data'),
      ]),
    );
  }
}
