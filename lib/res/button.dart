import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const PrimaryButton(
      {super.key,
      required this.text,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: AppColors.tertiary500,
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

class PrimaryInactiveButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const PrimaryInactiveButton(
      {super.key,
      required this.text,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: AppColors.tertiary500.withOpacity(0.4),
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

class OutlineButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const OutlineButton(
      {super.key,
      required this.text,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.black700),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: AppColors.black800,
      ),
    );
  }
}

class OutlineInactiveButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const OutlineInactiveButton(
      {super.key,
      required this.text,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.black700.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: AppColors.black800.withOpacity(0.3),
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const TertiaryButton(
      {super.key,
      required this.text,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.blue600),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: AppColors.blue700,
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
      this.height = 44,
      this.width = 116,
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

class LongButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const LongButton(
      {super.key,
      required this.text,
      this.height = 40,
      this.width = 160,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: AppColors.tertiary500,
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

class LongInactiveButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onPressed;
  const LongInactiveButton(
      {super.key,
      required this.text,
      this.height = 40,
      this.width = 160,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: AppColors.tertiary500.withOpacity(0.4),
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
