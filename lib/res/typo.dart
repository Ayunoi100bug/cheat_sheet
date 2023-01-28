import 'package:auto_size_text/auto_size_text.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:flutter/cupertino.dart';

class Bold24px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Bold24px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 24,
      this.activateOverflow = false,
      this.underline = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Medium24px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Medium24px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 24,
      this.activateOverflow = false,
      this.underline = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Medium20px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Medium20px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 20,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Medium14px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Medium14px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 14,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Medium12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Medium12px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 12,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Light20px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Light20px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 20,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Light14px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Light14px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 14,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Light12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Light12px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 12,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Medium16px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Medium16px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 16,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Regular16px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final FontWeight fontWeight;
  final bool activateOverflow;
  final bool underline;
  const Regular16px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 16,
      this.fontWeight = FontWeight.w400,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Regular14px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Regular14px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 14,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Regular12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Regular12px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 12,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Regular10px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool activateOverflow;
  final bool underline;
  const Regular10px(
      {super.key,
      this.color = AppColors.black800,
      required this.text,
      this.size = 10,
      this.activateOverflow = false,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: activateOverflow ? TextOverflow.ellipsis : null,
    );
  }
}
