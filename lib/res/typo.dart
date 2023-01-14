import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class Bold24px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Bold24px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 24,
      this.underline = false});
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class Medium24px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Medium24px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 24,
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
    );
  }
}

class Medium20px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Medium20px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 20,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class Medium14px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Medium14px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 14,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class Medium12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Medium12px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class Light20px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Light20px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 20,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}

class Light12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Light12px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}

class Light12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Light12px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis,
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
      overflow: overFlow,
    );
  }
}

class Medium16px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Medium16px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 16,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}

class Medium12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Medium12px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis,
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
      overflow: overFlow,
    );
  }
}

class Regular16px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final bool underline;
  const Regular16px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 16,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class Regular14px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Regular14px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 14,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}

class Regular12px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Regular12px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}

class Regular10px extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final bool underline;
  const Regular10px(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 10,
      this.overFlow = TextOverflow.ellipsis,
      this.underline = false});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: 'BaiJamjuree',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      overflow: overFlow,
    );
  }
}
