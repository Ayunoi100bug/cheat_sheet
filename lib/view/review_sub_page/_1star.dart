import 'package:cheat_sheet/res/components/review.dart';
import 'package:flutter/material.dart';

class OneStar extends StatelessWidget {
  const OneStar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Review(userRating: 5);
      },
    );
  }
}
