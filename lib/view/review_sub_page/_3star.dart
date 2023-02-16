import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class ThreeStar extends StatelessWidget {
  final String sheetId;
  const ThreeStar({super.key, required this.sheetId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
