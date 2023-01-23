import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view/home_screen/ask_question.dart';
import 'package:flutter/material.dart';

class AskAnswer extends StatefulWidget {
  // final Image userImage;
  // final String userName;
  // final int userRating;
  // final Text review;
  // final int like;
  // final int dislike;
  // const AskAnswer(
  //     {super.key,
  //     required this.userImage,
  //     required this.userName,
  //     required this.userRating,
  //     required this.review,
  //     required this.like,
  //     required this.dislike});

  @override
  State<AskAnswer> createState() => _AskAnswerState();
}

class _AskAnswerState extends State<AskAnswer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.032,
          //top: screenWidth * 0.016,
          right: screenWidth * 0.032,
          bottom: screenWidth * 0.024),
      child: Card(
        elevation: 4,
        shadowColor: AppColors.black900,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: isPortrait
                        ? constraints.maxWidth * 0.1
                        : constraints.maxWidth * 0.05,
                    child: Image.asset(
                      'assets/images/logo.png', //userImage
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: isPortrait
                                      ? constraints.maxWidth * 0.016
                                      : constraints.maxWidth * 0.008,
                                  right: isPortrait
                                      ? constraints.maxWidth * 0.016
                                      : constraints.maxWidth * 0.008),
                              width: isPortrait
                                  ? constraints.maxWidth * 0.6
                                  : constraints.maxWidth * 0.625,
                              child: Regular16px(text: "User Name"), //userName
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: isPortrait
                                      ? constraints.maxWidth * 0.016
                                      : constraints.maxWidth * 0.008,
                                  right: isPortrait
                                      ? constraints.maxWidth * 0.016
                                      : constraints.maxWidth * 0.008,
                                  bottom: isPortrait
                                      ? constraints.maxWidth * 0.016
                                      : constraints.maxWidth * 0.008),
                              width: isPortrait
                                  ? constraints.maxWidth * 0.3
                                  : constraints.maxWidth * 0.325,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.thumb_up_outlined,
                                      size: isPortrait
                                          ? constraints.maxWidth * 0.15
                                          : constraints.maxWidth * 0.075,
                                    ),
                                    SizedBox(
                                      width: isPortrait
                                          ? constraints.maxWidth * 0.05
                                          : constraints.maxWidth * 0.025,
                                    ),
                                    Regular16px(text: "99"), //like
                                    SizedBox(
                                      width: isPortrait
                                          ? constraints.maxWidth * 0.05
                                          : constraints.maxWidth * 0.025,
                                    ),
                                    Icon(
                                      Icons.thumb_down_outlined,
                                      size: isPortrait
                                          ? constraints.maxWidth * 0.15
                                          : constraints.maxWidth * 0.075,
                                    ),
                                    SizedBox(
                                      width: isPortrait
                                          ? constraints.maxWidth * 0.05
                                          : constraints.maxWidth * 0.025,
                                    ),
                                    Regular16px(text: "0"), //dislike
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: isPortrait
                                ? constraints.maxWidth * 0.016
                                : constraints.maxWidth * 0.008,
                            right: isPortrait
                                ? constraints.maxWidth * 0.016
                                : constraints.maxWidth * 0.008,
                            bottom: isPortrait
                                ? constraints.maxWidth * 0.016
                                : constraints.maxWidth * 0.008),
                        width: isPortrait
                            ? constraints.maxWidth * 0.9
                            : constraints.maxWidth * 0.95,
                        child: Regular16px(
                            text:
                                "ขอบคุณมากครับที่ทำสรุปดีๆแบบนี้ออกมาแนะนำเลยครับนักเขียนคนนี้เขียนดีทุกสรุปเลยครับ"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
