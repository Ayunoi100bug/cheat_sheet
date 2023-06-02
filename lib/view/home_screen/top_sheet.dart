import 'package:cheat_sheet/view/home_screen/review_sheet.dart';
import 'package:cheat_sheet/view/home_screen/top__sheet_sub_page.dart';
import 'package:cheat_sheet/view/review_sub_page/_4star.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/typo.dart';
import '../review_sub_page/_2star.dart';
import '../review_sub_page/_3star.dart';
import '../review_sub_page/_5star.dart';
import '../review_sub_page/all.dart';

class TopSheet extends StatefulWidget {
  const TopSheet({super.key});

  @override
  State<TopSheet> createState() => _TopSheetState();
}

int currentTab = 0;

class _TopSheetState extends State<TopSheet> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final tabsName = [
      'คณิตศาสตร์',
      'วิทยาศาสตร์',
      'ภาษาไทย',
      'ภาษาอังกฤษ',
      'สังคมศึกษา',
    ];

    final tabs = [
      tabTag('คณิตศาสตร์'),
      tabTag('วิทยาศาสตร์'),
      tabTag('ภาษาไทย'),
      tabTag('ภาษาอังกฤษ'),
      tabTag('สังคมศึกษา'),
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.016),
          width: screenWidth,
          height: screenHeight,
          child: DefaultTabController(
            length: tabs.length,
            child: NestedScrollView(
              scrollDirection: Axis.vertical,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (int index) {
                          currentTab = index;
                        },
                        isScrollable: true,
                        controller: tabController,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: Color.fromARGB(255, 43, 114, 116),
                        indicator: BoxDecoration(
                          color: Color.fromARGB(255, 148, 217, 219),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        unselectedLabelColor: AppColors.black500,
                        tabs: tabs,
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                controller: tabController,
                children: [
                  for (int i = 0; i < tabs.length; i++) ...[
                    TopSheetSubPage(tagName: tabsName[i]),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox tabTag(String text) {
  return SizedBox(
    child: Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    ),
  );
}
