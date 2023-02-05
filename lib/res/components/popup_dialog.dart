import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../button.dart';

Widget Popup_DeletePage(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    title: Column(
      children: [
        Image.asset(
          'assets/images/error.png',
          width: 70,
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular14px(text: 'ต้องการที่จะลบหน้านี้หรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular12px(
          text: 'หน้านี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(text: 'ยกเลิก', onPressed: () {}),
          PrimaryButton(
            text: 'ลบหน้านี้',
            onPressed: () {},
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_DeleteSheet(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    title: Column(
      children: [
        Image.asset(
          'assets/images/error.png',
          width: 70,
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular14px(text: 'ต้องการที่จะลบชีทหรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular12px(
          text: 'ชีทนี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(text: 'ยกเลิก', onPressed: () {}),
          PrimaryButton(
            text: 'ลบชีท',
            onPressed: () {},
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_DeleteSheetList(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    title: Column(
      children: [
        Image.asset(
          'assets/images/error.png',
          width: 70,
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular14px(text: 'ต้องการที่จะลบชีทลิสต์หรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular12px(
          text: 'ชีทลิสต์นี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(text: 'ยกเลิก', onPressed: () {}),
          PrimaryButton(
            text: 'ลบชีทลิสต์',
            onPressed: () {},
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_CancleCreate(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;

  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Column(
      children: [
        Image.asset(
          'assets/images/error.png',
          width: 70,
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular14px(text: 'ต้องการที่จะยกเลิกการสร้างชีทหรือไม่?'),
        Regular12px(
          text: 'หากคุณยกเลิก สิ่งที่คุณสร้างจะหายไป',
          color: AppColors.black600,
        ),
        SizedBox(
          height: screenHeight * 0.012,
        ),
        PrimaryButton(
          text: 'ยกเลิก การสร้างชีท',
          onPressed: () {},
          color: AppColors.error600,
        ),
        SizedBox(
          height: screenHeight * 0.004,
        ),
        PrimaryButton(
          text: 'บันทึกฉบับร่าง',
          onPressed: () {},
          color: AppColors.black400,
        ),
        SizedBox(
          height: screenHeight * 0.004,
        ),
        OutlineButton(text: 'ทำต่อ', onPressed: () {}),
      ],
    ),
  );
}
