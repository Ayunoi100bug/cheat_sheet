import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/view_model/file_passer_for_read.dart';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/question/detail_question.dart';
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
      //body: Text('Ask Question from sheet number' + widget.sheetId.toString()),
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
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _itemCount,
                        itemBuilder: (BuildContext context, int index) {
                          return Ask(
                            focus: _cardPosition == index ? true : false,
                            selectedIndex: 0,
                            currentIndex: 0,
                          );
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
