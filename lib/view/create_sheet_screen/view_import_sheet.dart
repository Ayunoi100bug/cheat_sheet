import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewImportSheet extends StatefulWidget {
  final File file;
  const ViewImportSheet({super.key, required this.file});

  @override
  State<ViewImportSheet> createState() => _ViewImportSheetState();
}

class _ViewImportSheetState extends State<ViewImportSheet> {
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
              icon: Icon(Icons.arrow_right_sharp)),
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () {
              AutoRouter.of(context).push(CreateDetailSheetRoute());
            },
            child: Text('ต่อไป'),
          ),
        ]),
      ],
    );
  }
}
