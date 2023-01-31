import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/answer.dart';
import 'package:cheat_sheet/view/home_screen/ask_question.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/components/ask.dart';

class TestUIPage extends StatefulWidget {
  const TestUIPage({super.key});

  @override
  State<TestUIPage> createState() => _TestUIPageState();
}

class _TestUIPageState extends State<TestUIPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
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
                // SizedBox(
                //   height:
                //       isPortrait ? screenHeight * 0.23 : screenHeight * 0.6,
                //   child: ListView.builder(
                //       controller: _scrollController,
                //       itemCount: _itemCount,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Ask(
                //           focus: _cardPosition == index ? true : false,
                //           selectedIndex: 0,
                //           currentIndex: 0,
                //         );
                //       }),
                // ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.amber,
                    height: screenHeight * 0.3,
                    child: Column(
                      children: [
                        Ask(
                          focus: true,
                          selectedIndex: 0,
                          currentIndex: 0,
                        ),
                        ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Answer(
                              focus: false,
                              selectedIndex: 0,
                              currentIndex: 0,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.only(
                //     top: screenHeight * 0.020,
                //     left: screenHeight * 0.036,
                //     right: screenHeight * 0.036,
                //     bottom: screenHeight * 0.020,
                //   ),
                //   child: LongButton(
                //     text: "เพิ่มความคิดเห็น",
                //     height: 42,
                //     width: screenWidth,
                //     onPressed: () {},
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
