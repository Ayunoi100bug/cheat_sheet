import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/model/review.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/components/popup_dialog.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Review extends StatefulWidget {
  final String sheetId;
  final String userId;
  final String userImage;
  final String userName;
  final double userRating;
  final String textReview;
  final String reviewId;
  final Timestamp dateTime;
  final int like;
  const Review(
      {super.key,
      required this.sheetId,
      required this.userId,
      required this.userImage,
      required this.userName,
      required this.userRating,
      required this.textReview,
      required this.reviewId,
      required this.dateTime,
      required this.like});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                                  itemBuilder: (context, index) => const Icon(
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
                                StreamBuilder(
                                    stream: _auth.authStateChanges(),
                                    builder: (context, AsyncSnapshot<User?> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          _BottomReview(context, widget.textReview, widget.userRating, widget.reviewId, widget.sheetId);
                                        },
                                        child: const Icon(
                                          FontAwesomeIcons.ellipsisV,
                                          color: AppColors.black700,
                                          size: 16,
                                        ),
                                      );
                                    }),
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

void _BottomReview(BuildContext context, String textReview, double rating, String reviewId, String sheetId) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  final _auth = FirebaseAuth.instance;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return SizedBox(
        height: isPortrait ? screenHeight * 0.18 : screenWidth * 0.18,
        child: Column(
          children: [
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(text: 'Edit')),
              onTap: () {
                _BottomEditReview(context, textReview, rating, reviewId);
              },
            ),
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(text: 'Delete')),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Popup_DeleteReview(context, reviewId, sheetId),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void _BottomEditReview(BuildContext context, String textReview, double ratingReview, String reviewId) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Reviews _review = Reviews(text: '', rid: '', reviewerId: '', sheetId: '', rating: 0, like: 0);
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  final _auth = FirebaseAuth.instance;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return SizedBox(
        height: isPortrait ? screenHeight * 0.5 : screenWidth * 0.5,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: isPortrait ? screenHeight * 0.15 : screenWidth * 0.15,
              alignment: Alignment.center,
              child: RatingBar.builder(
                initialRating: ratingReview,
                minRating: 0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.warning400,
                ),
                onRatingUpdate: (rating) {
                  _review.rating = rating;
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(isPortrait ? screenHeight * 0.02 : screenWidth * 0.02),
                height: isPortrait ? screenHeight * 0.2 : screenWidth * 0.2,
                child: MyTextFormField(
                  initialValue: textReview,
                  maxLine: 6,
                  minLine: 6,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    if (value == '') {
                      _review.text = textReview;
                    } else {
                      _review.text = value!;
                    }
                  },
                  validator: RequiredValidator(errorText: 'Please enter sheet list name.'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: screenHeight * 0.032),
              height: isPortrait ? screenHeight * 0.05 : screenWidth * 0.05,
              alignment: Alignment.centerRight,
              child: PrimaryButton(
                text: 'ส่ง',
                onPressed: () async {
                  if (_review.rating == 0) _review.rating = ratingReview;
                  _formKey.currentState!.save();
                  try {
                    EditReviewData().editReview(context, reviewId, _review.text, _review.rating).then((value) => _formKey.currentState!.reset());
                  } on FirebaseAuthException catch (e) {
                    FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                  }
                },
                size: 16,
              ),
            ),
          ],
        ),
      );
    },
  );
}
