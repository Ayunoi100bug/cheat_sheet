import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/model/answer.dart';
import 'package:cheat_sheet/res/components/answer.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/question_image_passer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';

import '../../../res/button.dart';
import '../../../res/components/ask.dart';
import '../../../res/components/flushbar.dart';
import '../../../res/components/flushbar_icon.dart';
import '../../../res/components/form_field.dart';
import '../../../view_model/create_firestore.dart';

const double A4_RATIO = 1 / 1.3;

class DetailQuestion extends StatefulWidget {
  final String sheetId;
  final String questionId;
  final int askingPage;
  const DetailQuestion({super.key, @PathParam() required this.sheetId, @PathParam() required this.questionId, required this.askingPage});

  @override
  State<DetailQuestion> createState() => _DetailQuestionState();
}

class _DetailQuestionState extends State<DetailQuestion> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    CreateCollection myCollection = CreateCollection();
    final AnswerModel _answer = AnswerModel(text: '', respondentId: '', sheetId: '', like: 0);

    final File? file = Provider.of<FilePasserForRead>(context).getFile();
    final File? questionImage = Provider.of<QuestionImagePasser>(context).getFile();

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection("question").doc(widget.questionId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> questionData = snapshot.data!.data() as Map<String, dynamic>;
        return StreamBuilder<DocumentSnapshot>(
            stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              Map<String, dynamic> sheetData = snapshot.data!.data() as Map<String, dynamic>;

              return StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection("users").doc(questionData['questionerId']).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    Map<String, dynamic>? user = userSnapshot.data!.data() as Map<String, dynamic>;

                    return Scaffold(
                      body: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: screenWidth * 0.08),
                                height: screenHeight * 0.4,
                                width: screenWidth,
                                child: Stack(
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
                                      child: Image.file(questionImage!),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.08),
                              Ask(
                                userId: user['uid'],
                                questionId: questionData['qid'],
                                userImage: user['profileImage'],
                                username: user['username'],
                                sheetId: widget.sheetId,
                                questionText: questionData["text"],
                                like: questionData['like'].toString(),
                              ),
                              const Answer(
                                focus: false,
                              ),
                              if (_auth.currentUser != null) ...[
                                Padding(
                                  padding: EdgeInsets.only(top: screenHeight * 0.012, left: screenHeight * 0.012, right: screenHeight * 0.012),
                                  child: Container(
                                    width: isPortrait ? screenWidth : screenWidth * 0.6,
                                    height: isPortrait ? screenHeight * 0.1 : screenHeight * 0.5,
                                    padding: EdgeInsets.all(screenHeight * 0.004),
                                    child: Form(
                                      key: _formKey,
                                      child: MyTextFormField(
                                        hintText: 'ตอบกลับคำถามได้ที่นี่',
                                        minLine: 5,
                                        maxLine: 5,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: RequiredValidator(errorText: 'กรุณากรอกคำถามให้เรียบร้อย'),
                                        onSaved: (value) {
                                          _answer.text = value!;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.025),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlineButton(
                                          text: 'ยกเลิก',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      PrimaryButton(
                                          text: 'ยืนยัน',
                                          onPressed: () async {
                                            _formKey.currentState!.save();
                                            try {
                                              myCollection
                                                  .createAnswerCollection(
                                                      _answer.text, _answer.aid, widget.sheetId, _auth.currentUser!.uid, widget.questionId, context)
                                                  .then((value) => _formKey.currentState!.reset());
                                            } on FirebaseAuthException catch (e) {
                                              FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
      },
    );
  }
}
