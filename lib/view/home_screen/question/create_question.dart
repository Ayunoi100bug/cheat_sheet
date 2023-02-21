import 'dart:io';

import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../res/button.dart';

class CreateQuestion extends StatefulWidget {
  final String sheetId;
  final int askingPage;
  const CreateQuestion({super.key, required this.sheetId, required this.askingPage});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    File? file = Provider.of<FilePasserForRead>(context).getFile();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: isPortrait ? constraints.maxHeight * 0.1 : constraints.maxHeight * 0.3,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: screenHeight * 0.008),
                          width: constraints.maxWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.pen,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.highlighter,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.eraser,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: isPortrait ? screenHeight * 0.008 : screenWidth * 0.08),
                          width: constraints.maxWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              boxColor(context, AppColors.primary400),
                              boxColor(context, AppColors.secondary400),
                              boxColor(context, AppColors.tertiary400),
                              boxColor(context, AppColors.error400),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  child: PdfDocumentLoader.openFile(
                    file!.path,
                    pageNumber: widget.askingPage,
                    pageBuilder: (context, textureBuilder, pageSize) => textureBuilder(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.012, left: screenHeight * 0.012, right: screenHeight * 0.012),
                  child: Container(
                    width: isPortrait ? screenWidth : screenWidth * 0.6,
                    height: isPortrait ? screenHeight * 0.1 : screenHeight * 0.5,
                    padding: EdgeInsets.all(screenHeight * 0.004),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black500),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      maxLines: null,
                      scrollPadding: const EdgeInsets.all(12.0),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'คำถาม',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.18, right: isPortrait ? 0 : screenWidth * 0.18),
                  height: screenWidth < 420 ? constraints.maxHeight * 0.1 : constraints.maxWidth * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(isPortrait ? screenWidth * 0.032 : screenWidth * 0.016),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(text: 'ยกเลิก', onPressed: () {}),
                        PrimaryButton(
                          text: 'ยืนยัน',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

Container boxColor(BuildContext context, Color color) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
  return Container(
    width: isPortrait ? screenHeight * 0.044 : screenWidth * 0.044,
    height: isPortrait ? screenHeight * 0.044 : screenWidth * 0.044,
    decoration: BoxDecoration(
      color: color,
    ),
  );
}
