import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/ask_answer.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/detail_question.dart';
import 'package:flutter/material.dart';

import '../../res/components/ask_answer.dart';

class AskQuestion extends StatefulWidget {
  final sheetId;
  const AskQuestion({super.key, @PathParam() required this.sheetId});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  late int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _scrollController = FixedExtentScrollController();
    final data = List.generate(20, (index) => 'Item $index');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.white,
          size: 40,
        ),
        onPressed: () {
          AutoRouter.of(context).push(
              DetailQuestionRoute(sheetId: widget.sheetId, questionId: 1));
        },
        backgroundColor: AppColors.tertiary600,
      ),
      //body: Text('Ask Question from sheet number' + widget.sheetId.toString()),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.024),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.020,
                        left: screenHeight * 0.036,
                        right: screenHeight * 0.036),
                    height: isPortrait
                        ? constraints.maxHeight * 0.6
                        : screenWidth * 0.4,
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
                  Container(
                    height: isPortrait
                        ? constraints.maxHeight * 0.4
                        : screenWidth * 0.6,
                    child: ClickableListWheelScrollView(
                      scrollController: _scrollController,
                      itemHeight: 120,
                      itemCount: data.length,
                      onItemTapCallback: (index) {
                        print("$index");
                      },
                      child: ListWheelScrollView.useDelegate(
                        controller: _scrollController,
                        itemExtent: 90,
                        physics: FixedExtentScrollPhysics(),
                        perspective: 0.0000001,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                          print('Index: ${value}');
                        },
                        squeeze: 1.1,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 4,
                          builder: (context, index) => index == currentIndex
                              ? AskAnswer(
                                  focus: true,
                                  selectedIndex: index,
                                  currentIndex: currentIndex,
                                )
                              : AskAnswer(
                                  focus: false,
                                  selectedIndex: index,
                                  currentIndex: currentIndex,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
