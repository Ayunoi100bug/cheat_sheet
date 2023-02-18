import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class FiveStar extends StatelessWidget {
  final String sheetId;
  const FiveStar({super.key, required this.sheetId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
