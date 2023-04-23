import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
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
      body: SafeArea(
          child: Row(
        children: [
          Text('นี่คือหน้าถามระดับชั้น'),
          ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(AboutSubjectRoute(grade: 'ชั้น'));
              },
              child: Text('ไปหน้าถามวิชา'))
        ],
      )),
    );
  }
}
