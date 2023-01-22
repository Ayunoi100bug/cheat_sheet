import 'package:auto_route/annotations.dart';
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
      body: Text('Ask Question from sheet number' + widget.sheetId.toString()),
    );
  }
}
