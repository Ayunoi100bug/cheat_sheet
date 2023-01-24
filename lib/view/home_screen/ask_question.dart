import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/detail_question.dart';
import 'package:flutter/material.dart';

class AskQuestion extends StatefulWidget {
  final int sheetId;
  const AskQuestion({super.key, @PathParam() required this.sheetId});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text('Ask Question from sheet number' + widget.sheetId.toString()),
        ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(CreateQuestionRoute());
            },
            child: Text('ปุ่มหน้าสร้างคำถาม')),
        ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(
                  DetailQuestionRoute(sheetId: widget.sheetId, questionId: 1));
            },
            child: Text('ปุ่มหน้าดูคำถาม')),
      ]),
    );
  }
}
