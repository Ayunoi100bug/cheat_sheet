import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Achievement extends StatelessWidget {
  final String achievementName;
  final int completeTime;
  final int doingTime;
  final int recievePoint;
  const Achievement({
    super.key,
    required this.achievementName,
    required this.completeTime,
    required this.doingTime,
    required this.recievePoint,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth * 0.15,
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
                                  Icon(
                                    Icons.monetization_on_outlined,
                                    color: AppColors.warning500,
                                    size: screenHeight * 0.024,
                                  )
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary500, width: 1.0),
                              ),
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * 0.25,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
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
    );
  }
}
