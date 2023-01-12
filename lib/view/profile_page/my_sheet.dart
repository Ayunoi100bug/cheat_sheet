import 'package:cheat_sheet/res/colors.dart';
import 'package:flutter/material.dart';

class MySheet extends StatelessWidget {
  const MySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange100,
      body: Center(
        child: Text(
          'Tab 1',
          style: TextStyle(
            color: AppColors.primary400,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
