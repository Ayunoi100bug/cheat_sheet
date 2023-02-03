import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import '../colors.dart';
import '../typo.dart';

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Regular16px(
              text: 'ชีทลิสต์ใหม่',
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                textAlign: TextAlign.center,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ชื่อชีทลิสต์',
                ),
              ),
            ),
            PrimaryButton(
              text: 'บันทึก',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
