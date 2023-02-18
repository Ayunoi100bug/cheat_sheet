import 'package:cheat_sheet/res/components/review.dart';
import 'package:flutter/material.dart';

class OneStar extends StatelessWidget {
  final String sheetId;
  const OneStar({super.key, required this.sheetId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
