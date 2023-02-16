import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class FourStar extends StatelessWidget {
  final String sheetId;
  const FourStar({super.key, required this.sheetId});

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
