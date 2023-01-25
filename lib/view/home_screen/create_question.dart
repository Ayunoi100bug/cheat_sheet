import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../res/button.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({super.key});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: isPortrait
                      ? constraints.maxHeight * 0.1
                      : constraints.maxHeight * 0.3,
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
                                size: isPortrait
                                    ? screenHeight * 0.036
                                    : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.highlighter,
                                size: isPortrait
                                    ? screenHeight * 0.036
                                    : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.eraser,
                                size: isPortrait
                                    ? screenHeight * 0.036
                                    : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: isPortrait
                                  ? screenHeight * 0.008
                                  : screenWidth * 0.08),
                          width: constraints.maxWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                height: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                decoration: BoxDecoration(
                                  color: AppColors.primary400,
                                ),
                              ),
                              Container(
                                width: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                height: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                decoration: BoxDecoration(
                                  color: AppColors.secondary400,
                                ),
                              ),
                              Container(
                                width: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                height: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                decoration: BoxDecoration(
                                  color: AppColors.tertiary400,
                                ),
                              ),
                              Container(
                                width: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                height: isPortrait
                                    ? screenHeight * 0.044
                                    : screenWidth * 0.044,
                                decoration: BoxDecoration(
                                  color: AppColors.warning400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  child: Image.network(
                    "https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_04.jpg",
                    height: isPortrait
                        ? constraints.maxHeight * 0.7
                        : constraints.maxWidth * 0.7,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.012,
                      left: screenHeight * 0.012,
                      right: screenHeight * 0.012),
                  child: Container(
                    width: isPortrait ? screenWidth : screenWidth * 0.6,
                    height:
                        isPortrait ? screenHeight * 0.1 : screenHeight * 0.5,
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
                  padding: EdgeInsets.only(
                      left: isPortrait ? 0 : screenWidth * 0.18,
                      right: isPortrait ? 0 : screenWidth * 0.18),
                  height: screenWidth < 420
                      ? constraints.maxHeight * 0.1
                      : constraints.maxWidth * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(
                        isPortrait ? screenWidth * 0.032 : screenWidth * 0.016),
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
