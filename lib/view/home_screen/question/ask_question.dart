import 'dart:io';

import 'package:cheat_sheet/data/network/image_api.dart';
import 'package:cheat_sheet/res/colors.dart';

import 'package:cheat_sheet/view_model/file_passer_for_read.dart';
import 'package:cheat_sheet/view_model/question_image_passer.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/components/ask.dart';
import '../../../res/components/popup_auth.dart';
import '../../../res/typo.dart';

class AskQuestion extends StatefulWidget {
  final String sheetId;
  final int askingPage;
  const AskQuestion({
    super.key,
    @PathParam() required this.sheetId,
    required this.askingPage,
  });

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    File? file = Provider.of<FilePasserForRead>(context).getFile();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_auth.currentUser != null) {
            AutoRouter.of(context).push(CreateQuestionRoute(sheetId: widget.sheetId, askingPage: widget.askingPage));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => Popup_Login(context),
            );
          }
        },
        backgroundColor: AppColors.tertiary600,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.024),
            child: Column(
              children: [
                SizedBox(
                  height: isPortrait ? screenHeight * 0.8 : screenHeight * 0.6,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('question')
                          .where('sheetId', isEqualTo: widget.sheetId)
                          .where('askingPage', isEqualTo: widget.askingPage)
                          .orderBy('numOfLike', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        int questionCount = snapshot.data!.docs.length;
                        if (questionCount == 0) {
                          return SizedBox(
                            height: screenWidth * 0.57,
                            child: const Center(
                              child: Regular16px(text: "ยังไม่มีคำถาม"),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: questionCount,
                          itemBuilder: (context, index) {
                            DocumentSnapshot question = snapshot.data!.docs[index];

                            return StreamBuilder<DocumentSnapshot>(
                                stream: _firestore.collection('users').doc(question['questionerId']).snapshots(),
                                builder: (context, userSnapshot) {
                                  if (!userSnapshot.hasData) {
                                    return Container();
                                  } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  Map<String, dynamic>? user = userSnapshot.data?.data() as Map<String, dynamic>?;
                                  return InkWell(
                                    onTap: () async {
                                      File questionImage = await ImageApi.loadQuestionImage(question.id);
                                      if (context.mounted) {
                                        Provider.of<QuestionImagePasser>(context, listen: false).setFile(questionImage);
                                        AutoRouter.of(context).push(
                                            DetailQuestionRoute(questionId: question.id, sheetId: widget.sheetId, askingPage: widget.askingPage));
                                      }
                                    },
                                    child: Ask(
                                      userId: user?['uid'],
                                      questionId: question['qid'],
                                      userImage: user?['profileImage'],
                                      username: user?['username'],
                                      sheetId: widget.sheetId,
                                      questionText: question['text'],
                                      like: question['like'],
                                    ),
                                  );
                                });
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
