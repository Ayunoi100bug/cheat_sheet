import 'package:flutter/material.dart';

import '../../res/colors.dart';

class BuySheet extends StatelessWidget {
  const BuySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary100,
      body: Center(
        child: Container(
          child: Text(
            'Tab 2',
            style: TextStyle(
              color: AppColors.primary400,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
