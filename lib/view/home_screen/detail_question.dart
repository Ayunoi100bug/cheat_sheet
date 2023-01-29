import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class DetailQuestion extends StatefulWidget {
  final String sheetId;
  final int questionId;
  const DetailQuestion(
      {super.key,
      @PathParam() required this.sheetId,
      @PathParam() required this.questionId});

  @override
  State<DetailQuestion> createState() => _DetailQuestionState();
}

class _DetailQuestionState extends State<DetailQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('นี่คือหน้ารายละเอียดคำถาม ของชีท ' +
          widget.sheetId +
          ' และของคำถามที่ ' +
          widget.questionId.toString()),
    );
  }
}
