import 'package:flutter/material.dart';

class PickDemoPages extends StatefulWidget {
  const PickDemoPages({super.key});

  @override
  State<PickDemoPages> createState() => _PickDemoPagesState();
}

class _PickDemoPagesState extends State<PickDemoPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('นี่คือหน้าเลือกตัวอย่างชีท'),
    );
  }
}
