import 'package:cheat_sheet/res/components/ask_answer.dart';
import 'package:flutter/material.dart';

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({super.key});

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: AskAnswer()),
    );
  }
}
