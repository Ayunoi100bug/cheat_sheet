import 'package:flutter/material.dart';

import '../colors.dart';
import '../typo.dart';

Widget Popup_CCV(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    title: Column(
      children: [
        const Medium24px(text: 'รหัสความปลอดภัย'),
        Padding(
          padding: EdgeInsets.only(
              top: isPortrait ? screenHeight * 0.02 : screenHeight * 0.032),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.black700),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: isPortrait ? screenHeight * 0.032 : screenHeight * 0.06),
              child: Column(
                children: [
                  Container(
                    height:
                        isPortrait ? screenHeight * 0.04 : screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.black700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: isPortrait
                            ? screenHeight * 0.02
                            : screenHeight * 0.1,
                        left: isPortrait
                            ? screenHeight * 0.054
                            : screenHeight * 0.12,
                        bottom: isPortrait
                            ? screenHeight * 0.024
                            : screenHeight * 0.036),
                    child: Row(
                      children: [
                        SizedBox(
                          height: isPortrait
                              ? screenHeight * 0.024
                              : screenHeight * 0.068,
                          width: isPortrait
                              ? screenHeight * 0.12
                              : screenHeight * 0.32,
                          child: Container(
                            color: AppColors.black300,
                          ),
                        ),
                        SizedBox(
                          width: isPortrait
                              ? screenHeight * 0.012
                              : screenHeight * 0.02,
                        ),
                        const Regular12px(text: '123'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: isPortrait ? screenHeight * 0.02 : screenHeight * 0.04),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Medium16px(text: 'หมายเลข CVV คือรหัส 3 หลัก'),
                Medium16px(text: 'ที่อยู่ข้างช่องลายเซ็นต์บนด้านหลังบัตร'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
