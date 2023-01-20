import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class FourStar extends StatelessWidget {
  const FourStar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Review(userRating: 5);
      },
    );
  }
}
