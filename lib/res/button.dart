import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

import 'components/custom_appbar.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final double size;
  final bool coinIcon;
  final void Function() onPressed;
  const PrimaryButton(
      {super.key,
      required this.text,
      this.color = AppColors.tertiary500,
      this.textcolor = AppColors.white,
      this.height = 44,
      this.width = 116,
      this.size = 16,
      this.coinIcon = false,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (coinIcon) ...[
            CustomAppBar.coin,
            SizedBox(
              width: 6,
            ),
          ],
          Regular16px(
            text: text,
            color: textcolor,
            size: size,
          ),
        ],
      ),
    );
  }
}

class PrimaryInactiveButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const PrimaryInactiveButton(
      {super.key,
      required this.text,
      this.color = AppColors.tertiary500,
      this.textcolor = AppColors.white,
      this.height = 44,
      this.width = 116,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: color.withOpacity(0.4),
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
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const OutlineButton(
      {super.key,
      required this.text,
      this.color = AppColors.black700,
      this.textcolor = AppColors.black800,
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
        side: BorderSide(color: color),
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

class OutlineInactiveButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const OutlineInactiveButton(
      {super.key,
      required this.text,
      this.color = AppColors.black700,
      this.textcolor = AppColors.black800,
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
        side: BorderSide(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Regular16px(
        text: text,
        color: textcolor.withOpacity(0.3),
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const TertiaryButton(
      {super.key,
      required this.text,
      this.color = AppColors.blue600,
      this.textcolor = AppColors.blue700,
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
        side: BorderSide(color: color),
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

class WarningButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const WarningButton(
      {super.key,
      required this.text,
      this.color = AppColors.error600,
      this.textcolor = AppColors.white,
      this.height = 44,
      this.width = 116,
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

class LongButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const LongButton(
      {super.key,
      required this.text,
      this.color = AppColors.tertiary500,
      this.textcolor = AppColors.white,
      this.height = 40,
      this.width = 160,
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
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scaleX: -1,
              child: Icon(
                Icons.message_outlined,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.03,
            ),
            Regular16px(
              text: text,
              color: textcolor,
            ),
          ],
        );
      }),
    );
  }
}

class LongInactiveButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final void Function() onPressed;
  const LongInactiveButton(
      {super.key,
      required this.text,
      this.color = AppColors.tertiary500,
      this.textcolor = AppColors.white,
      this.height = 40,
      this.width = 160,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: color.withOpacity(0.4),
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
