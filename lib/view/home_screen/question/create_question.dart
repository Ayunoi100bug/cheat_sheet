import 'dart:io';
import 'dart:math';

import 'package:cheat_sheet/data/network/image_api.dart';
import 'package:cheat_sheet/model/question.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:painter/painter.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../res/components/flushbar.dart';
import '../../../res/components/flushbar_icon.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

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

    String questionId = _question.qid;

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
                          child: Row(
                            children: [
                              SizedBox(
                                width: isPortrait ? screenWidth * 0.012 : screenHeight * 0.1,
                              ),
                              Icon(
                                Icons.undo,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
                                color: AppColors.black700,
                              ),
                              SizedBox(
                                width: isPortrait ? screenWidth * 0.04 : screenHeight * 0.2,
                              ),
                              Icon(
                                Icons.brush,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
                                color: AppColors.black700,
                              ),
                              SizedBox(
                                width: isPortrait ? screenWidth * 0.04 : screenHeight * 0.2,
                              ),
                              Icon(
                                FontAwesomeIcons.eraser,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
                                color: AppColors.black700,
                              ),
                              SizedBox(
                                width: isPortrait ? screenWidth * 0.056 : screenHeight * 0.22,
                              ),
                              Icon(
                                Icons.delete,
                                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
                                color: AppColors.black700,
                              ),
                              SizedBox(
                                width: isPortrait ? screenWidth * 0.044 : screenHeight * 0.44,
                              ),
                              Slider(
                                value: _controller.thickness,
                                onChanged: (value) => {},
                                min: 1.0,
                                max: 20.0,
                                activeColor: AppColors.primary500,
                                inactiveColor: AppColors.black300,
                              ),
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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait ? screenHeight * 0.012 : screenWidth * 0.024, left: screenHeight * 0.008, right: screenHeight * 0.008),
                      child: Container(
                        width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.9,
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
                    FloatingActionButton(
                      onPressed: () async {
                        PictureDetails image = _controller.finish();
                        _formKey.currentState!.save();
                        try {
                          firebaseStorage.UploadTask? task = await ImageApi.uploadToFirebase(image, questionId);
                          task!.whenComplete(() {
                            myCollection
                                .createQuestionCollection(_question.text, questionId, _question.sheetId = widget.sheetId,
                                    _question.questionerId = _auth.currentUser!.uid, context, _question.askingPage = widget.askingPage)
                                .then((value) => _formKey.currentState!.reset());
                          });
                        } on FirebaseAuthException catch (e) {
                          FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                        }
                      },
                      backgroundColor: AppColors.tertiary600,
                      child: Transform.rotate(
                          angle: 90 * pi / 180,
                          child: const Icon(
                            Icons.navigation,
                            size: 28,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
