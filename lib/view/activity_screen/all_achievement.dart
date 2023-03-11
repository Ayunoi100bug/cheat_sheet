import 'package:flutter/material.dart';

class AllAchievement extends StatefulWidget {
  const AllAchievement({super.key});

  @override
  State<AllAchievement> createState() => _AllAchievementState();
}

class _AllAchievementState extends State<AllAchievement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('นี่คือหน้าความสำเร็จทั้งหมด'),
      ),
    );
  }
}
