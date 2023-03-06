import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/model/question.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/popup_dialog.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view/home_screen/question/ask_question.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../view_model/update_firestore.dart';
import '../button.dart';
import 'flushbar.dart';
import 'form_field.dart';

class Ask extends StatefulWidget {
  final bool focus;
  final String userImage;
  final String username;
  final String questionText;
  final String sheetId;
  const Ask({
    super.key,
    required this.focus,
    required this.userImage,
    required this.username,
    required this.questionText,
    required this.sheetId,
  });

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.032, right: screenWidth * 0.032, bottom: screenWidth * 0.024),
      child: Card(
        color: widget.focus ? AppColors.warning100 : AppColors.white,
        elevation: 6,
        shadowColor: widget.focus ? AppColors.error600 : AppColors.black600,
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
                          backgroundImage: CachedNetworkImageProvider(widget.userImage),
                          radius: 12,
                        ),
                      ),
                      onTap: () {
                        print("user image");
                      },
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
                                text: widget.username,
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
                                    child: GestureDetector(
                                      child: Icon(Icons.thumb_up_off_alt_outlined, size: 18),
                                      onTap: () {},
                                    ),
                                  ),
                                  Regular14px(text: "99"),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  // InkWell(
                                  //   child: widget.userId == _auth.currentUser!.uid
                                  //       ? Icon(
                                  //           FontAwesomeIcons.ellipsisV,
                                  //           size: 16,
                                  //         )
                                  //       : Container(),
                                  //   onTap: () {
                                  //     _BottomQuestion(context, widget.questionText, widget.questionId, widget.sheetId);
                                  //   },
                                  // ),
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
                            text: widget.questionText,
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

void _BottomQuestion(BuildContext context, String textQuestion, String questionId, String sheetId) {
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
                _BottomEditQuestion(context, textQuestion, questionId);
              },
            ),
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(
                    text: 'Delete',
                    color: AppColors.error500,
                  )),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Popup_DeleteQuestion(context, questionId, sheetId),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void _BottomEditQuestion(BuildContext context, String textQuestion, String questionId) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Question _question = Question(text: '', sheetId: '', questionerId: '', askingPage: 0);
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
        height: isPortrait ? screenHeight * 0.25 : screenWidth * 0.25,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(isPortrait ? screenHeight * 0.02 : screenWidth * 0.02),
                height: isPortrait ? screenHeight * 0.15 : screenWidth * 0.15,
                child: MyTextFormField(
                  initialValue: textQuestion,
                  maxLine: 2,
                  minLine: 2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    if (value == '') {
                      _question.text = textQuestion;
                    } else {
                      _question.text = value!;
                    }
                  },
                  validator: RequiredValidator(errorText: 'กรุณากรอกคำถามของท่าน.'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: screenHeight * 0.032),
              height: isPortrait ? screenHeight * 0.05 : screenWidth * 0.05,
              alignment: Alignment.centerRight,
              child: PrimaryButton(
                text: 'แก้ไข',
                onPressed: () async {
                  _formKey.currentState!.save();
                  try {
                    EditQuestionData().editQuestion(context, questionId, _question.text).then((value) => _formKey.currentState!.reset());
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
