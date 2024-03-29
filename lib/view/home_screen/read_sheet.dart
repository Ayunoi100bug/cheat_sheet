import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';
import '../../utils/routes/routes.gr.dart';

class ReadSheet extends StatefulWidget {
  final String sheetId;
  final String sheetTitle;
  const ReadSheet({super.key, @PathParam() required this.sheetId, required this.sheetTitle});

  @override
  State<ReadSheet> createState() => _ReadSheetState();
}

late bool isOpen = false;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ReadSheetState extends State<ReadSheet> {
  final _firestore = FirebaseFirestore.instance;
  late PDFViewController controller;
  int numberPages = 0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    File? file = Provider.of<FilePasserForRead>(context).getFile();

    Future.delayed(const Duration(minutes: 1), () {
      UpdateCollection().achievement(context, 'trackingReadSheet');
    });

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        splashColor: AppColors.tertiary600,
        backgroundColor: AppColors.tertiary700.withOpacity(0.7),
        elevation: 0,
        onPressed: () async {
          AutoRouter.of(context).push(AskQuestionRoute(
            sheetId: widget.sheetId,
            askingPage: currentPage + 1,
          ));
        },
        child: Bold16px(
          text: "ถาม",
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              padding: EdgeInsets.only(top: screenHeight * 0.012),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.10 : screenWidth * 0.05,
                    width: screenWidth,
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          alignment: Alignment.center,
                          child: Bold24px(
                            text: widget.sheetTitle,
                            activateOverflow: true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: screenWidth * 0.075),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.9,
              height: isOpen ? screenHeight * 0.47 : screenHeight * 0.67,
              child: PDFView(
                filePath: file!.path,
                pageSnap: false,
                pageFling: false,
                onRender: (pages) => setState(() => this.numberPages = pages!),
                onViewCreated: (controller) => setState(() => this.controller = controller),
                onPageChanged: (indexPage, _) => setState(() => this.currentPage = indexPage!),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.018),
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.black400,
                  border: Border.all(color: AppColors.black400),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Regular16px(
                  text: (currentPage + 1).toString() + "/" + (numberPages).toString(),
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// return Scaffold(
//       body: Column(
//         children: [
//           Text('This is Read Sheet Page of Sheet number ' +
//               widget.sheetId.toString()),
//           InkWell(
//             child: Text('Ask Question'),
//             onTap: () {
//               AutoRouter.of(context)
//                   .push(AskQuestionRoute(sheetId: widget.sheetId));
//             },
//           )
//         ],
//       ),
//     );