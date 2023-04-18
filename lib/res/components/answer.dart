import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/popup_auth.dart';
import 'package:cheat_sheet/res/components/popup_dialog.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../model/answer.dart';
import '../../view_model/auth.dart';
import '../../view_model/update_firestore.dart';
import '../button.dart';
import '../gap_dimension.dart';
import 'form_field.dart';

class Answer extends StatefulWidget {
  final String userId;
  final String userImage;
  final String userName;
  final String answerId;
  final String answerText;
  final List like;
  final String questionId;
  const Answer({
    super.key,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.answerId,
    required this.answerText,
    required this.like,
    required this.questionId,
  });

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.032, bottom: screenWidth * 0.024),
      child: Card(
        color: AppColors.white,
        elevation: 6,
        shadowColor: AppColors.black600,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: SizedBox(
                        width: isPortrait ? constraints.maxWidth * 0.12 : constraints.maxWidth * 0.05,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(widget.userImage),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                              ),
                              width: isPortrait ? constraints.maxWidth * 0.56 : constraints.maxWidth * 0.625,
                              child: Regular16px(
                                text: widget.userName,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                              ),
                              width: isPortrait ? constraints.maxWidth * 0.32 : constraints.maxWidth * 0.325,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: InkWell(
                                      child: Icon(
                                        widget.like.contains(_auth.currentUser?.uid)
                                            ? Icons.thumb_up_off_alt_rounded
                                            : Icons.thumb_up_off_alt_outlined,
                                        color: widget.like.contains(_auth.currentUser?.uid) ? AppColors.black600 : AppColors.black600,
                                        size: 18,
                                      ),
                                      onTap: () async {
                                        if (widget.like.contains(_auth.currentUser?.uid)) {
                                          if (AuthService().isLogged()) {
                                            await EditAnswerData().removeAnswerLike(widget.answerId, _auth.currentUser!.uid);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => Popup_Login(context),
                                            );
                                          }
                                        } else {
                                          if (AuthService().isLogged()) {
                                            await EditAnswerData().increaseAnswerLike(widget.answerId, _auth.currentUser!.uid);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => Popup_Login(context),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  Regular14px(text: widget.like.length.toString()),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  InkWell(
                                    child: widget.userId == _auth.currentUser?.uid
                                        ? Icon(
                                            FontAwesomeIcons.ellipsisV,
                                            size: 16,
                                            color: AppColors.black600,
                                          )
                                        : Container(),
                                    onTap: () {
                                      _BottomAnswer(context, widget.answerText, widget.answerId, widget.questionId);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isPortrait ? constraints.maxWidth * 0.024 : constraints.maxWidth * 0.012,
                            vertical: isPortrait ? constraints.maxWidth * 0.01 : constraints.maxWidth * 0.01,
                          ),
                          width: isPortrait ? constraints.maxWidth * 0.88 : constraints.maxWidth * 0.95,
                          child: Regular14px(
                            color: AppColors.black600,
                            text: widget.answerText,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

void _BottomAnswer(BuildContext context, String answerText, String answerId, String questionId) {
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
                  child: const Regular16px(text: 'แก้ไขคำตอบ')),
              onTap: () {
                _BottomEditAnswer(context, answerText, answerId);
              },
            ),
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(
                    text: 'ลบคำตอบ',
                    color: AppColors.error500,
                  )),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Popup_DeleteAnswer(context, answerId, questionId),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void _BottomEditAnswer(BuildContext context, String answerText, String answerId) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnswerModel _answer = AnswerModel(text: '', respondentId: '');
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
        height: MediaQuery.of(context).viewInsets.bottom == 0
            ? screenHeight * 0.3
            : (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) / 1,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(isPortrait ? screenHeight * 0.02 : screenWidth * 0.02),
                height: isPortrait ? screenHeight * 0.15 : screenWidth * 0.15,
                child: MyTextFormField(
                  initialValue: answerText,
                  maxLine: 6,
                  minLine: 6,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    if (value == '') {
                      _answer.text = answerText;
                    } else {
                      _answer.text = value!;
                    }
                  },
                  validator: RequiredValidator(errorText: 'กรุณากรอกคำตอบของท่าน.'),
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
                    await EditAnswerData().editAnswer(context, answerId, _answer.text).then((value) => _formKey.currentState!.reset());
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
