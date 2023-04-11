import 'package:flutter/material.dart';

class TopSheet extends StatefulWidget {
  const TopSheet({super.key});

  @override
  State<TopSheet> createState() => _TopSheetState();
}

class _TopSheetState extends State<TopSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('นี่คือหน้าชีทยอดนิยม'),
      ),
    );
  }
}
