import 'package:another_flushbar/flushbar.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class FlushbarPopup {
  static successFlushbar(BuildContext context, Icon icon, String message) {
    return Flushbar(
      backgroundColor: AppColors.secondary500,
      margin: EdgeInsets.all(8),
      icon: icon,
      shouldIconPulse: false,
      messageText: Regular14px(
        text: message,
        color: AppColors.white,
      ),
      boxShadows: [
        BoxShadow(
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: -1.0,
            color: AppColors.black400),
        BoxShadow(
            offset: Offset(0.0, 4.0),
            blurRadius: 5.0,
            color: AppColors.black400),
        BoxShadow(
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
            color: AppColors.black400),
      ],
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  static errorFlushbar(BuildContext context, Icon icon, String message) {
    return Flushbar(
      backgroundColor: AppColors.error600,
      margin: EdgeInsets.all(8),
      icon: icon,
      shouldIconPulse: false,
      messageText: Regular14px(
        text: message,
        color: AppColors.white,
      ),
      boxShadows: [
        BoxShadow(
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: -1.0,
            color: AppColors.black400),
        BoxShadow(
            offset: Offset(0.0, 4.0),
            blurRadius: 5.0,
            color: AppColors.black400),
        BoxShadow(
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
            color: AppColors.black400),
      ],
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}
