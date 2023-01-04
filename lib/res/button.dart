import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const PrimaryButton(
      {super.key,
      this.color = AppColors.tertiary500,
      this.textcolor = AppColors.white,
      required this.text,
      required this.height,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: textcolor,
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const OutlineButton(
      {super.key,
      this.color = AppColors.black800,
      this.textcolor = AppColors.black800,
      required this.text,
      required this.height,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: color)),
        child: Regular16px(
          text: text,
          color: textcolor,
        ),
      ),
    );
  }
}

class WarningButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const WarningButton(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: AppColors.error600,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: AppColors.white,
      ),
    );
  }
}
