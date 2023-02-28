import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EditDemo extends StatefulWidget {
  final String sheetId;
  const EditDemo({super.key, @PathParam() required this.sheetId});

  @override
  State<EditDemo> createState() => _EditDemoState();
}

class _EditDemoState extends State<EditDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('นี่คือหน้าแก้ไขเดโม่'),
    );
  }
}
