import 'dart:ui';

import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'custom_appbar.dart';

class Achievement extends StatelessWidget {
  final String achievementName;
  final int completeTime;
  final int doingTime;
  final int recievePoint;
  final bool success;
  const Achievement({
    super.key,
    required this.achievementName,
    required this.completeTime,
    required this.doingTime,
    required this.recievePoint,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(right: screenWidth * 0.05),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth * 0.13,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Icon(
                      FontAwesomeIcons.trophy,
                      color: AppColors.warning500,
                      size: constraints.maxHeight * 0.6,
                    );
                  },
                ),
              ),
              SizedBox(width: constraints.maxWidth * 0.02),
              SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.5,
                              width: constraints.maxWidth * 0.7,
                              child: Row(
                                children: [
                                  Regular16px(text: achievementName),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.5,
                              width: constraints.maxWidth * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(recievePoint.toString()),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.01,
                                  ),
                                  CustomAppBar.coin,
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary500, width: 1.0),
                                ),
                                width: constraints.maxWidth,
                                height: constraints.maxHeight * 0.25,
                                child: LayoutBuilder(builder: (context, constraints) {
                                  return SizedBox(
                                    child: LinearPercentIndicator(
                                      padding: EdgeInsets.zero,
                                      width: constraints.maxWidth,
                                      lineHeight: constraints.maxHeight,
                                      percent: doingTime / completeTime,
                                      center: Regular12px(
                                        text: "$doingTime/$completeTime",
                                      ),
                                      backgroundColor: AppColors.white,
                                      progressColor: AppColors.primary500,
                                    ),
                                  );
                                })),
                          ],
                        ),
                      ],
                    );
                  })),
            ],
          );
        }),
      ),
      success == true
          ? Container(
              decoration: BoxDecoration(color: (AppColors.black400).withOpacity(0.7)),
            )
          : Container(),
      success == true
          ? Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/complete.png',
                fit: BoxFit.fitWidth,
                width: 250,
              ),
            )
          : Container(),
    ]);
  }
}
