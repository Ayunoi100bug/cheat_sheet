import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
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

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        splashColor: AppColors.warning100,
        backgroundColor: AppColors.warning200.withOpacity(0.7),
        elevation: 0,
        onPressed: () async {
          AutoRouter.of(context).push(AskQuestionRoute(
            sheetId: widget.sheetId,
            askingPage: currentPage + 1,
          ));
        },
        child: const Icon(
          Icons.question_mark_outlined,
          color: AppColors.error500,
          size: 30,
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
                            text: "sheetName",
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
            Stack(
              children: [
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
                Container(
                  width: screenWidth * 0.9,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: screenWidth * 0.02, right: screenWidth * 0.02),
                  child: Icon(
                    Icons.bookmark_outline,
                    size: 36,
                    color: AppColors.black700,
                  ),
                ),
              ],
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