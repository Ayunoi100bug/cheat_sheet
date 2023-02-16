import 'dart:io';

import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/answer.dart';
import 'package:cheat_sheet/view/home_screen/ask_question.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../res/colors.dart';
import '../res/components/ask.dart';

class TestUIPage extends StatefulWidget {
  const TestUIPage({super.key});

  @override
  State<TestUIPage> createState() => _TestUIPageState();
}

class _TestUIPageState extends State<TestUIPage> {
  late File file;

  void _test() async {
    file = await PDFApi.loadPDFFromFirebase(
        'Db23hb7tMcZHJI2qCN1h6WBa5lg2', '0acd3070-a8e5-11ed-9796-a72ec0804056');
    PdfDocument doc = PdfDocument(inputBytes: file.readAsBytesSync());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _test();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Text(file.path),
    );
  }
}
