import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class ThreeStar extends StatelessWidget {
  const ThreeStar({super.key});

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
