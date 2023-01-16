import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({super.key});

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Review(),
    );
  }
}
