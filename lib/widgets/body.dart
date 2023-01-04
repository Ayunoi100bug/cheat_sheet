import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  const Body(
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 16,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'BaiJamjuree',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500),
      overflow: overFlow,
    );
  }
}
