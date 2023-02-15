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
