import 'package:flutter/material.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({super.key});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('นี่คือหน้าสร้างคำถาม'),
    );
  }
}
