import 'package:flutter/material.dart';

class RecommendSheet extends StatefulWidget {
  const RecommendSheet({super.key});

  @override
  State<RecommendSheet> createState() => _ReccommendSheetState();
}

class _ReccommendSheetState extends State<RecommendSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('นี่คือหน้าชีทที่แนะนำ!'),
      ),
    );
  }
}
