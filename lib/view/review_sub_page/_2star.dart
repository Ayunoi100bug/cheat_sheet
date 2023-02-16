import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class TwoStar extends StatelessWidget {
  final String sheetId;
  const TwoStar({super.key, required this.sheetId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
