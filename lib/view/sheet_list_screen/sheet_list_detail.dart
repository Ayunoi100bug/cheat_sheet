import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SheetListDetail extends StatefulWidget {
  final String sheetId;
  const SheetListDetail({super.key, @pathParam required this.sheetId});

  @override
  State<SheetListDetail> createState() => _SheetListDetailState();
}

class _SheetListDetailState extends State<SheetListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('นี่คือหน้าชีทลิสต์ id ' +
            widget.sheetId +
            ' หล่ะยะหุ้วๆๆๆกุ้วๆกิ้วๆ'),
      ),
    );
  }
}
