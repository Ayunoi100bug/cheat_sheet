import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/ask_answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

import '../../res/components/ask_answer.dart';

class AskQuestion extends StatefulWidget {
  final sheetId;
  final Widget? inViewArea;

  const AskQuestion(
      {super.key, @PathParam() required this.sheetId, this.inViewArea});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    // var isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      //body: Text('Ask Question from sheet number' + widget.sheetId.toString()),
      body: Container(
        color: AppColors.black400,
        height: 700,
        child: InViewNotifierList(
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.7 * vpHeight) &&
                deltaBottom > (0.9 * vpHeight);
          },
          itemCount: 10,
          builder: (BuildContext context, int index) {
            return InViewNotifierWidget(
              id: '$index',
              builder: (BuildContext context, bool isInView, child) {
                return Container(
                  height: 200.0,
                  color: isInView ? Colors.green : Colors.red,
                  child: Text(
                    isInView ? 'Is in view' : 'Not in view',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
