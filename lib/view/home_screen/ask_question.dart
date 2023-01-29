import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/colors.dart';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/detail_question.dart';
import 'package:flutter/material.dart';

import '../../res/components/ask.dart';

class AskQuestion extends StatefulWidget {
  final String sheetId;
  const AskQuestion({super.key, @PathParam() required this.sheetId});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  late int currentIndex = 0;
  late ScrollController _scrollController;

  final int _itemCount = 10;

  int _cardPosition = 0;

  void _scrollListenerWithItemCount() {
    int itemCount = _itemCount;
    double scrollOffset = _scrollController.position.pixels;
    double viewportHeight = _scrollController.position.viewportDimension;
    double scrollRange = _scrollController.position.maxScrollExtent * 0.99 -
        _scrollController.position.minScrollExtent;
    int firstVisibleItemIndex =
        (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.white,
          size: 40,
        ),
        onPressed: () {
          AutoRouter.of(context).push(CreateQuestionRoute());
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
                  height: isPortrait
                      ? constraints.maxHeight * 0.6
                      : constraints.maxHeight * 0.4,
                  child: SizedBox(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.error300,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_04.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('${_cardPosition}');
                  },
                  child: SizedBox(
                    height:
                        isPortrait ? screenHeight * 0.23 : screenHeight * 0.6,
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
