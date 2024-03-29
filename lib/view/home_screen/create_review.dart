import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/review.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class CreateReview extends StatefulWidget {
  final String sheetId;
  const CreateReview({super.key, @PathParam() required this.sheetId});

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Reviews _review = Reviews(text: '', rid: '', reviewerId: '', sheetId: '', rating: 0, like: 0);
  CreateCollection myCollection = CreateCollection();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  height: screenHeight * 0.2,
                  child: MyTextFormField(
                    maxLine: 6,
                    minLine: 6,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: 'แสดงความคิดเห็นที่นี่...',
                    onSaved: (value) {
                      _review.text = value!;
                    },
                    validator: RequiredValidator(errorText: ''),
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
                    _formKey.currentState!.save();
                    try {
                      myCollection
                          .createReviewCollection(
                            _review.text,
                            _review.rid = uuid.v4(),
                            _review.reviewerId = _auth.currentUser!.uid,
                            _review.sheetId = widget.sheetId,
                            _review.rating,
                            _review.like!,
                            context,
                            _review.rid,
                          )
                          .then((value) => _formKey.currentState!.reset());
                    } on FirebaseAuthException catch (e) {
                      FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                    }
                  },
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
