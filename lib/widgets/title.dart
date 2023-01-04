import 'package:flutter/cupertino.dart';

class Title extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  const Title({
    super.key,
    this.color = const Color(0xff000000),
    required this.text,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'BaiJamjuree',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500),
    );
  }
}
