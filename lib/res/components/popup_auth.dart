import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/routes/routes.gr.dart';
import '../button.dart';

Widget Popup_Login(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Column(
      children: [
        Icon(
          Icons.login_outlined,
          color: AppColors.primary600,
          size: 40,
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Medium20px(text: 'กรุณาเข้าสู่ระบบก่อนใช้งาน'),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            text: 'เข้าสู่ระบบ',
            onPressed: () {
              AutoRouter.of(context).push(LoginRoute());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ],
  );
}

Widget Popup_error(BuildContext context, String title, String content) {
  return AlertDialog(
    title: Bold20px(text: title),
    content: SingleChildScrollView(
      child: ListBody(
        children: [
          Regular16px(text: content),
        ],
      ),
    ),
    actions: [
      TextButton(
        child: Regular16px(
          text: 'ตกลง',
          fontWeight: FontWeight.w500,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
