import 'dart:io';

import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Test extends StatefulWidget {
  final File file;
  const Test({super.key, required this.file});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: widget.file.path,
    );
  }
}
