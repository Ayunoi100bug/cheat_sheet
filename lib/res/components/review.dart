import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review extends StatefulWidget {
  // final Image userImage;
  // final String userName;
  final double userRating;
  // final Text review;
  // final DateTime dateTime;
  // final int like;
  const Review({
    super.key,
    //     required this.userImage,
    //     required this.userName,
    required this.userRating,
    //     required this.review,
    //     required this.dateTime,
    //     required this.like}
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.016),
      width: double.infinity,
      child: Card(
        elevation: 4,
        shadowColor: AppColors.black900,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.016),
                      child: Row(
                        children: [
                          Container(
                            width: isPortrait
                                ? constraints.maxWidth * 0.1
                                : constraints.maxWidth * 0.05,
                            child: Image.asset(
                              'assets/images/logo.png', //userImage
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth * 0.6,
                            padding:
                                EdgeInsets.all(constraints.maxWidth * 0.008),
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Light14px(
                                    text: 'Artmuchi', //userName
                                  ),
                                  RatingBarIndicator(
                                    rating: widget.userRating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: AppColors.warning400,
                                    ),
                                    itemCount: 5,
                                    itemSize: 25,
                                  ),
                                ],
                              );
                            }),
                          ),
                          Container(
                            padding:
                                EdgeInsets.all(constraints.maxWidth * 0.016),
                            width: isPortrait
                                ? constraints.maxWidth * 0.268
                                : constraints.maxWidth * 0.318,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.thumb_up_outlined,
                                    size: isPortrait
                                        ? constraints.maxWidth * 0.15
                                        : constraints.maxWidth * 0.075,
                                  ),
                                  SizedBox(
                                    width: isPortrait
                                        ? constraints.maxWidth * 0.1
                                        : constraints.maxWidth * 0.05,
                                  ),
                                  Regular14px(text: "100"), //like
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.016,
                          top: constraints.maxWidth * 0.004,
                          right: constraints.maxWidth * 0.008,
                          bottom: constraints.maxWidth * 0.016),
                      child: Regular12px(
                          text:
                              'ขอบคุณมากครับที่ทำสรุปดีๆแบบนี้ออกมาแนะนำเลยครับนักเขียนคนนี้เขียนดีทุกสรุปเลยครับ'), //userReview
                    ),
                    Container(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.016),
                      child: Regular10px(text: '11/11/2022'), //dateTime
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
