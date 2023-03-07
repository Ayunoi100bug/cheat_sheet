import 'package:flutter/material.dart';

class AboutGrade extends StatefulWidget {
  const AboutGrade({super.key});

  @override
  State<AboutGrade> createState() => _AboutGradeState();
}

class _AboutGradeState extends State<AboutGrade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('นี่คือหน้าถามระดับชั้น'),
    );
  }
}
