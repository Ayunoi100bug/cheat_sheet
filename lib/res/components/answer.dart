import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import '../gap_dimension.dart';

class Answer extends StatefulWidget {
  final bool focus;
  const Answer({
    super.key,
    required this.focus,
  });

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.032, bottom: screenWidth * 0.024),
      child: Card(
        color: widget.focus ? AppColors.warning100 : AppColors.white,
        elevation: 6,
        shadowColor: widget.focus ? AppColors.error600 : AppColors.black600,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: SizedBox(
                        width: isPortrait ? constraints.maxWidth * 0.12 : constraints.maxWidth * 0.05,
                        child: Image.asset(
                          'assets/images/logo.png', //userImage
                        ),
                      ),
                      onTap: () {},
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                              ),
                              width: isPortrait ? constraints.maxWidth * 0.56 : constraints.maxWidth * 0.625,
                              child: Regular16px(
                                text: "UserName",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                              ),
                              width: isPortrait ? constraints.maxWidth * 0.32 : constraints.maxWidth * 0.325,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.thumb_up_off_alt_outlined,
                                        size: 18,
                                      ),
                                      onTap: () {
                                        print("like");
                                      },
                                    ),
                                  ),
                                  Regular14px(text: "20")
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                            vertical: isPortrait ? constraints.maxWidth * 0.01 : constraints.maxWidth * 0.01,
                          ),
                          width: isPortrait ? constraints.maxWidth * 0.88 : constraints.maxWidth * 0.95,
                          child: Regular14px(
                            color: AppColors.black600,
                            text: "ใช่ครับ แบบนี้ถูกแล้ว",
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
