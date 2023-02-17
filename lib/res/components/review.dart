import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Review extends StatefulWidget {
  final String userImage;
  final String userName;
  final double userRating;
  final String textReview;
  final Timestamp dateTime;
  final int like;
  const Review(
      {super.key,
      required this.userImage,
      required this.userName,
      required this.userRating,
      required this.textReview,
      required this.dateTime,
      required this.like});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Card(
      elevation: 4,
      shadowColor: AppColors.black900,
      child: Column(
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
                        SizedBox(
                          width: isPortrait ? constraints.maxWidth * 0.1 : constraints.maxWidth * 0.05,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: CachedNetworkImageProvider(widget.userImage),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.6,
                          padding: EdgeInsets.all(constraints.maxWidth * 0.008),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Light14px(
                                  text: widget.userName,
                                ),
                                RatingBarIndicator(
                                  rating: widget.userRating,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: AppColors.warning400,
                                  ),
                                  itemCount: 5,
                                  itemSize: 12,
                                ),
                              ],
                            );
                          }),
                        ),
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.016),
                          width: isPortrait ? constraints.maxWidth * 0.268 : constraints.maxWidth * 0.318,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.thumb_up_outlined,
                                  size: isPortrait ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.075,
                                ),
                                SizedBox(
                                  width: isPortrait ? constraints.maxWidth * 0.1 : constraints.maxWidth * 0.05,
                                ),
                                Regular14px(text: widget.like.toString()),
                                SizedBox(
                                  width: isPortrait ? constraints.maxWidth * 0.1 : constraints.maxWidth * 0.05,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    FontAwesomeIcons.ellipsisV,
                                    size: 16,
                                  ),
                                ),
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
                    child: Regular12px(text: widget.textReview),
                  ),
                  Container(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.016),
                    child: Regular10px(text: widget.dateTime.toDate().toString()),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
