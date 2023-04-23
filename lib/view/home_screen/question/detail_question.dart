import 'dart:io';
import 'dart:math';

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
import 'package:uuid/uuid.dart';

import '../../../res/colors.dart';
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
    var padding = MediaQuery.of(context).viewPadding;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    CreateCollection myCollection = CreateCollection();
    final AnswerModel _answer = AnswerModel(text: '', respondentId: '', like: []);

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
        List? answerInQuestion = questionData['answer'];
        answerInQuestion ?? [];
        return StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> sheetSnapshot) {
            if (!sheetSnapshot.hasData) {
              return Container();
            } else if (sheetSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic>? sheetData = sheetSnapshot.data!.data() as Map<String, dynamic>;
            return StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection("users").doc(questionData['questionerId']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (!userSnapshot.hasData) {
                  return Container();
                } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic>? user = userSnapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  resizeToAvoidBottomInset: false,
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
                            like: questionData['like'],
                          ),
                          answerInQuestion!.isEmpty
                              ? SizedBox(
                                  height: screenHeight * 0.2,
                                )
                              : SizedBox(
                                  height: _auth.currentUser != null ? screenHeight * 0.2 : screenHeight * 0.31,
                                  child: ListView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: answerInQuestion.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return StreamBuilder<DocumentSnapshot>(
                                        stream: _firestore.collection("answer").doc(answerInQuestion[index]).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> answerSnapshot) {
                                          if (!answerSnapshot.hasData) {
                                            return Container();
                                          } else if (answerSnapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          return StreamBuilder<DocumentSnapshot>(
                                            stream: _firestore.collection("users").doc(answerSnapshot.data?['respondentId']).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userAnswerSnapshot) {
                                              if (!userAnswerSnapshot.hasData) {
                                                return Container();
                                              } else if (userAnswerSnapshot.connectionState == ConnectionState.waiting) {
                                                return const Center(child: CircularProgressIndicator());
                                              }
                                              return Answer(
                                                userImage: userAnswerSnapshot.data?['profileImage'],
                                                userName: userAnswerSnapshot.data?['username'],
                                                answerText: answerSnapshot.data?['text'],
                                                like: answerSnapshot.data?['like'],
                                                questionId: questionData['qid'],
                                                answerId: answerSnapshot.data?['aid'],
                                                userId: userAnswerSnapshot.data?['uid'],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                          if (_auth.currentUser != null) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.02),
                              child: Expanded(
                                child: Wrap(
                                  children: [
                                    Container(
                                      width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.6,
                                      height: isPortrait ? screenWidth * 0.16 : screenHeight * 0.5,
                                      padding: EdgeInsets.all(screenHeight * 0.004),
                                      child: Form(
                                        key: _formKey,
                                        child: MyTextFormField(
                                          hintText: 'ตอบกลับคำถามได้ที่นี่',
                                          minLine: 5,
                                          maxLine: 5,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: RequiredValidator(errorText: 'กรอกคำถามให้เรียบร้อย'),
                                          onSaved: (value) {
                                            _answer.text = value!;
                                          },
                                        ),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () async {
                                        _formKey.currentState!.save();
                                        try {
                                          String answerId = const Uuid().v4();
                                          await myCollection.createAnswerCollection(
                                              _answer.text, answerId, _auth.currentUser!.uid, widget.questionId, context);
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
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
