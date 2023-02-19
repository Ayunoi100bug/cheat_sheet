import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/flushbar.dart';
import '../../res/typo.dart';

class ViewImportSheet extends StatefulWidget {
  const ViewImportSheet({super.key});

  @override
  State<ViewImportSheet> createState() => _ViewImportSheetState();
}

class _ViewImportSheetState extends State<ViewImportSheet> {
  late PDFViewController controller;
  int numberPages = 0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    File? pdfFile = Provider.of<FilePasser>(context).getFile();

    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: screenHeight * 0.005),
          child: const Icon(
            Icons.file_download_outlined,
            size: 36,
          ),
        ),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.64,
          child: PDFView(
            filePath: pdfFile?.path,
            pageSnap: false,
            pageFling: false,
            onRender: (pages) => setState(() => this.numberPages = pages!),
            onViewCreated: (controller) => setState(() => this.controller = controller),
            onPageChanged: (indexPage, _) => setState(() => this.currentPage = indexPage!),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
          child: Container(
            alignment: Alignment.center,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              color: AppColors.black400,
              border: Border.all(color: AppColors.black400),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Regular16px(
              text: (currentPage + 1).toString() + "/" + (numberPages).toString(),
              color: AppColors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                onPressed: () {
                  AutoRouter.of(context).pop();
                },
                text: 'ยกเลิก',
              ),
              PrimaryButton(
                onPressed: () {
                  AutoRouter.of(context).push(const CreateDetailSheetRoute());
                },
                text: 'ต่อไป',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
