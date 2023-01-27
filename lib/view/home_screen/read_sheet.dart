import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../res/colors.dart';
import '../../res/components/bottom_sheet.dart';
import '../../utils/routes/routes.gr.dart';

class ReadSheet extends StatefulWidget {
  final int sheetId;
  final File file;
  const ReadSheet(
      {super.key, @PathParam() required this.sheetId, required this.file});

  @override
  State<ReadSheet> createState() => _ReadSheetState();
}

late bool isOpen = false;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ReadSheetState extends State<ReadSheet> {
  late PDFViewController controller;
  int numberPages = 0;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Container(
        padding: !isOpen
            ? EdgeInsets.only(bottom: screenWidth * 0.04)
            : EdgeInsets.only(bottom: screenWidth * 0.18),
        child: FloatingActionButton(
          splashColor: AppColors.warning100,
          backgroundColor: AppColors.warning200.withOpacity(0.7),
          elevation: 0,
          onPressed: () {
            AutoRouter.of(context)
                .push(AskQuestionRoute(sheetId: widget.sheetId));
          },
          child: const Icon(
            Icons.back_hand_outlined,
            color: AppColors.warning600,
            size: 30,
          ),
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
                    height:
                        isPortrait ? screenWidth * 0.10 : screenWidth * 0.05,
                    width: screenWidth,
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          alignment: Alignment.center,
                          child: Bold24px(text: "สถิติพื้นฐาน"),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: screenWidth * 0.075),
                          // child: Icon(
                          //   Icons.book_outlined,
                          //   size: 36,
                          //   color: AppColors.black700,
                          // ),
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
                    filePath: widget.file.path,
                    pageSnap: false,
                    pageFling: false,
                    onRender: (pages) =>
                        setState(() => this.numberPages = pages!),
                    onViewCreated: (controller) =>
                        setState(() => this.controller = controller),
                    onPageChanged: (indexPage, _) =>
                        setState(() => this.currentPage = indexPage!),
                  ),
                ),
                Container(
                  width: screenWidth * 0.9,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      top: screenWidth * 0.02, right: screenWidth * 0.02),
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
                  text: (currentPage + 1).toString() +
                      "/" +
                      (numberPages).toString(),
                  color: AppColors.white,
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   height:
            //       isOpen ? screenHeight * 0.11 - 37 : screenHeight * 0.13 - 37,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 28, vertical: 2),
            //     decoration: BoxDecoration(
            //       color: AppColors.black400,
            //       border: Border.all(color: AppColors.black400),
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(20),
            //       ),
            //     ),
            //     child: Regular16px(
            //       text: "1/5",
            //       color: AppColors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // bottomSheet: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       alignment: Alignment.center,
      //       color: AppColors.black300,
      //       height: screenHeight * 0.03,
      //       width: screenWidth,
      //       child: OutlinedButton(
      //         style: OutlinedButton.styleFrom(
      //           minimumSize: Size.fromHeight(40),
      //           side: BorderSide(
      //             color: Colors.transparent,
      //           ),
      //         ),
      //         child: Icon(
      //           isOpen
      //               ? Icons.keyboard_double_arrow_down
      //               : Icons.keyboard_double_arrow_up,
      //           color: AppColors.black900,
      //         ),
      //         onPressed: () {
      //           setState(() {
      //             isOpen = !isOpen;
      //           });
      //         },
      //       ),
      //     ),
      //     isOpen ? BottomSheetWidget() : Container(),
      //   ],
      // ),
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