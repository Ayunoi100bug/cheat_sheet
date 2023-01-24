import 'package:flutter/material.dart';

class TestUIPage extends StatefulWidget {
  const TestUIPage({super.key});

  @override
  State<TestUIPage> createState() => _TestUIPageState();
}

class _TestUIPageState extends State<TestUIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('หน้าสำหรับการทดสอบ UI สำหรับทุ๊กกคลลล'),
    );
  }
}
