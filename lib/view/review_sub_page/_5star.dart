import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class FiveStar extends StatelessWidget {
  const FiveStar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Review(userRating: 5);
      },
    );
  }
}
