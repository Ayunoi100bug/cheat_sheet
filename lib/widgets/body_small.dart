import 'package:flutter/cupertino.dart';

class BodySmall extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  const BodySmall(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'BaiJamjuree',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w400),
      overflow: overFlow,
    );
  }
}
