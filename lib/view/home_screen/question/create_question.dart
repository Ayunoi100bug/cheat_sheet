import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cheat_sheet/model/question.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/image_passer.dart';
import 'package:cheat_sheet/view_model/to_image_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:painter/painter.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../res/button.dart';
import '../../../res/components/flushbar.dart';
import '../../../res/components/flushbar_icon.dart';

const double A4_RATIO = 1 / 1.3;

class CreateQuestion extends StatefulWidget {
  final String sheetId;
  final int askingPage;
  const CreateQuestion({super.key, required this.sheetId, required this.askingPage});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  PainterController _controller = _newController();
  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.backgroundColor = Colors.green.withOpacity(0.2);
    controller.thickness = 5.0;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    final Question _question = Question(text: '', questionerId: '', sheetId: '', askingPage: 0);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    CreateCollection myCollection = CreateCollection();
    final _auth = FirebaseAuth.instance;

    File? file = Provider.of<FilePasserForRead>(context).getFile();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: isPortrait ? constraints.maxHeight * 0.1 : constraints.maxHeight * 0.3,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: screenHeight * 0.008),
                          width: constraints.maxWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.pen,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.highlighter,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                              Icon(
                                FontAwesomeIcons.eraser,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.036,
                                color: AppColors.black600,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: isPortrait ? screenHeight * 0.008 : screenWidth * 0.08),
                          width: constraints.maxWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              boxColor(context, AppColors.primary400),
                              boxColor(context, AppColors.secondary400),
                              boxColor(context, AppColors.tertiary400),
                              boxColor(context, AppColors.error400),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: A4_RATIO,
                      child: PdfDocumentLoader.openFile(
                        file!.path,
                        pageNumber: widget.askingPage,
                        pageBuilder: (context, textureBuilder, pageSize) => textureBuilder(),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: A4_RATIO,
                      child: Painter(_controller),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.012, left: screenHeight * 0.012, right: screenHeight * 0.012),
                  child: Container(
                    width: isPortrait ? screenWidth : screenWidth * 0.6,
                    height: isPortrait ? screenHeight * 0.1 : screenHeight * 0.5,
                    padding: EdgeInsets.all(screenHeight * 0.004),
                    child: Form(
                      key: _formKey,
                      child: MyTextFormField(
                        hintText: 'กรอกคำถามได้ที่นี่',
                        minLine: 5,
                        maxLine: 5,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: RequiredValidator(errorText: 'กรุณากรอกคำถามให้เรียบร้อย'),
                        onSaved: (value) {
                          _question.text = value!;
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.18, right: isPortrait ? 0 : screenWidth * 0.18),
                  height: screenWidth < 420 ? constraints.maxHeight * 0.1 : constraints.maxWidth * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(isPortrait ? screenWidth * 0.032 : screenWidth * 0.016),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(text: 'ยกเลิก', onPressed: () {}),
                        PrimaryButton(
                            text: 'ยืนยัน',
                            onPressed: () async {
                              var image = await ToImageWidget.toImage(_controller.finish());
                              Provider.of<ImagePasser>(context, listen: false).setImage(image);
                              _formKey.currentState!.save();
                              try {
                                myCollection
                                    .createQuestionCollection(_question.text, _question.sheetId = widget.sheetId,
                                        _question.questionerId = _auth.currentUser!.uid, context, _question.askingPage = widget.askingPage)
                                    .then((value) => _formKey.currentState!.reset());
                              } on FirebaseAuthException catch (e) {
                                FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                              }
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

Container boxColor(BuildContext context, Color color) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
  return Container(
    width: isPortrait ? screenHeight * 0.044 : screenWidth * 0.044,
    height: isPortrait ? screenHeight * 0.044 : screenWidth * 0.044,
    decoration: BoxDecoration(
      color: color,
    ),
  );
}
