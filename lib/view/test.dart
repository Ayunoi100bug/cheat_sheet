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
  late PDFViewController controller;
  int numberPages = 0;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 800,
          width: 600,
          child: SizedBox(
            child: PDFView(
              filePath: widget.file.path,
              pageSnap: false,
              pageFling: false,
              onRender: (pages) => setState(() => this.numberPages = pages!),
              onViewCreated: (controller) =>
                  setState(() => this.controller = controller),
              onPageChanged: (indexPage, _) =>
                  setState(() => this.currentPage = indexPage!),
            ),
          ),
        ),
        Row(children: [
          Text('page ' +
              (currentPage + 1).toString() +
              '/' +
              numberPages.toString()),
          IconButton(
              onPressed: () {
                final changePageIndex =
                    currentPage == 0 ? currentPage : currentPage - 1;
                controller.setPage(changePageIndex);
              },
              icon: Icon(Icons.arrow_left_sharp)),
          IconButton(
              onPressed: () {
                final changePageIndex =
                    currentPage == numberPages ? currentPage : currentPage + 1;
                controller.setPage(changePageIndex);
              },
              icon: Icon(Icons.arrow_right_sharp))
        ]),
      ],
    );
  }
}
