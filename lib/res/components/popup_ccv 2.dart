import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../typo.dart';

Widget Popup_CCV(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Column(
      children: [
        Medium24px(text: 'รหัสความปลอดภัย'),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Medium16px(text: 'หมายเลข CVV คือรหัส 3 หลัก'),
              Medium16px(text: 'ที่อยู่ข้างช่องลายเซ็นต์บนด้านหลังบัตร'),
            ],
          ),
        ),
      ],
    ),
  );
}
