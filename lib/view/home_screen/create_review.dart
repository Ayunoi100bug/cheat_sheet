import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CreateReview extends StatefulWidget {
  final String sheetId;
  const CreateReview({super.key, @PathParam() required this.sheetId});

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.15,
                alignment: Alignment.center,
                child: RatingBar.builder(
                  minRating: 1,
                  allowHalfRating: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppColors.warning400,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Container(
                width: isPortrait ? screenWidth : screenWidth * 0.6,
                height: isPortrait ? screenHeight * 0.3 : screenHeight * 0.5,
                padding: EdgeInsets.all(screenHeight * 0.032),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black800),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    maxLines: null,
                    scrollPadding: const EdgeInsets.all(20.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'แสดงความคิดเห็นที่นี่...',
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: screenHeight * 0.032),
                height: isPortrait ? screenHeight * 0.05 : screenWidth * 0.05,
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  text: 'ส่ง',
                  onPressed: () {},
                  size: 16,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              )
            ],
          ),
        );
      })),
    );
  }
}
