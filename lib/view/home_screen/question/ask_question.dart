import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/question/detail_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';

import '../../../res/components/ask.dart';

class AskQuestion extends StatefulWidget {
  final String sheetId;
  final int askingPage;
  const AskQuestion({super.key, @PathParam() required this.sheetId, required this.askingPage});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  late int currentIndex = 0;
  late ScrollController _scrollController;

  final int _itemCount = 100;

  int _cardPosition = 0;

  void _scrollListenerWithItemCount() {
    int itemCount = _itemCount;
    double scrollOffset = _scrollController.position.pixels;
    double viewportHeight = _scrollController.position.viewportDimension;
    double scrollRange = _scrollController.position.maxScrollExtent - 1 - _scrollController.position.minScrollExtent;
    int firstVisibleItemIndex = (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();

    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (isTop) {
        _cardPosition = 0;
      } else {
        _cardPosition = firstVisibleItemIndex + 1;
      }
    } else {
      _cardPosition = firstVisibleItemIndex + 1;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListenerWithItemCount);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListenerWithItemCount);
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
        child: Icon(
          Icons.add,
          color: AppColors.white,
          size: 40,
        ),
        onPressed: () {
          AutoRouter.of(context).push(CreateQuestionRoute(sheetId: widget.sheetId, askingPage: widget.askingPage));
        },
        backgroundColor: AppColors.tertiary600,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.024),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.020,
                    left: screenHeight * 0.036,
                    right: screenHeight * 0.036,
                    bottom: screenHeight * 0.020,
                  ),
                  height: isPortrait ? constraints.maxHeight * 0.6 : constraints.maxHeight * 0.4,
                  child: Container(
                    child: PdfDocumentLoader.openFile(
                      file!.path,
                      pageNumber: widget.askingPage,
                      pageBuilder: (context, textureBuilder, pageSize) => textureBuilder(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('${_cardPosition}');
                  },
                  child: SizedBox(
                    height: isPortrait ? screenHeight * 0.23 : screenHeight * 0.6,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection("question").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot questionSnapshot) {
                          if (!questionSnapshot.hasData) {
                            return Container();
                          } else if (questionSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final myQuestion = questionSnapshot.data?.docs.where((document) => document["askingPage"] == widget.askingPage);
                          return ListView.builder(
                              controller: _scrollController,
                              itemCount: myQuestion!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final question = myQuestion!.elementAt(index);
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: _firestore.collection("users").doc(question['questionerId']).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot userSnapshot) {
                                      if (!userSnapshot.hasData) {
                                        return Container();
                                      } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
                                      return Ask(
                                        authorId: userData['uid'],
                                        userImage: userData['profileImage'],
                                        username: userData['username'],
                                        sheetId: widget.sheetId,
                                        questionText: question['text'],
                                        focus: _cardPosition == index ? true : false,
                                        selectedIndex: 0,
                                        currentIndex: 0,
                                      );
                                    });
                              });
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
