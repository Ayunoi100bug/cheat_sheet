import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/delete_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../button.dart';
import 'flushbar.dart';
import 'flushbar_icon.dart';

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

Widget Popup_DeleteAllSheet(BuildContext context) {
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
        const Regular14px(text: 'ต้องการที่จะลบชีททั้งหมดหรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        const Regular12px(
          text: 'ชีทนี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
              text: 'ยกเลิก',
              onPressed: () {
                Navigator.pop(context);
              }),
          PrimaryButton(
            text: 'ลบชีท',
            onPressed: () {
              DeleteCollection().deleteAllSheet(context);
            },
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_DeleteSheet(BuildContext context, String sheetId) {
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
        const Regular14px(text: 'ต้องการที่จะลบชีทหรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        const Regular12px(
          text: 'ชีทนี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
              text: 'ยกเลิก',
              onPressed: () {
                Navigator.pop(context);
              }),
          PrimaryButton(
            text: 'ลบชีท',
            onPressed: () {
              DeleteDocument().deleteSheet(context, sheetId);
            },
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_DeleteReview(BuildContext context, String reviewId, String sheetId) {
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
        const Regular14px(text: 'ต้องการที่จะลบความคิดเห็นนี้หรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        const Regular12px(
          text: 'ความคิดเห็นนี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
              text: 'ยกเลิก',
              onPressed: () {
                Navigator.pop(context);
              }),
          PrimaryButton(
            text: 'ลบความคิดเห็น',
            onPressed: () {
              DeleteDocument().deleteReview(context, reviewId, sheetId);
            },
            color: AppColors.error600,
          ),
        ],
      ),
    ],
  );
}

Widget Popup_DeleteQuestion(BuildContext context, String questionId, String sheetId) {
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
        Regular14px(text: 'ต้องการที่จะลบคำถามนี้หรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Regular12px(
          text: 'คำถามนี้จะถูกลบถาวร',
          color: AppColors.black600,
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
              text: 'ยกเลิก',
              onPressed: () {
                Navigator.pop(context);
              }),
          PrimaryButton(
            text: 'ลบคำถาม',
            onPressed: () {
              DeleteDocument().deleteQuestion(context, questionId, sheetId);
            },
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
        const Regular14px(text: 'ต้องการที่จะลบชีทลิสต์หรือไม่?'),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        const Regular12px(
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
            onPressed: () {
              Navigator.of(context).pop();
              AutoRouter.of(context).navigateNamed('/sheet_list');
              DeleteDocument().deleteSheetList(context, sheetListId).then((value) {
                FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, 'ลบชีทลิสต์สำเร็จ');
              });
            },
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
        const Regular14px(text: 'ต้องการที่จะยกเลิกการสร้างชีทหรือไม่?'),
        const Regular12px(
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
