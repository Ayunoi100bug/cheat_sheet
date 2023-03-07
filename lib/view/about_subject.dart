import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';

class AboutSubject extends StatefulWidget {
  const AboutSubject({super.key});

  @override
  State<AboutSubject> createState() => _AboutSubjectState();
}

class _AboutSubjectState extends State<AboutSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Text('นี่คือหน้าถามรายวิชา'),
        ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(AboutGradeRoute());
            },
            child: Text('ถัดไป'))
      ])),
    );
  }
}
