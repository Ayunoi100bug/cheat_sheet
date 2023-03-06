import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/typo.dart';

import '../review_sub_page/_1star.dart';
import '../review_sub_page/_2star.dart';
import '../review_sub_page/_3star.dart';
import '../review_sub_page/_4star.dart';
import '../review_sub_page/_5star.dart';
import '../review_sub_page/all.dart';

class ReviewSheet extends StatefulWidget {
  final String sheetId;
  const ReviewSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

int currentTab = 0;

class _ReviewSheetState extends State<ReviewSheet> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
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

    final tabs = [
      const SizedBox(
        width: 70,
        child: Tab(
          child: Regular16px(text: 'ทั้งหมด'),
        ),
      ),
      tabReview('5'),
      tabReview('4'),
      tabReview('3'),
      tabReview('2'),
      tabReview('1'),
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.016),
          width: screenWidth,
          height: screenHeight,
          child: DefaultTabController(
            length: 6,
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
                        labelColor: AppColors.tertiary500,
                        indicator: BoxDecoration(
                          border: Border.all(color: AppColors.tertiary500, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        unselectedLabelColor: AppColors.black400,
                        tabs: tabs,
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                controller: tabController,
                children: [
                  All(sheetId: widget.sheetId),
                  FiveStar(sheetId: widget.sheetId),
                  FourStar(sheetId: widget.sheetId),
                  ThreeStar(sheetId: widget.sheetId),
                  TwoStar(sheetId: widget.sheetId),
                  OneStar(sheetId: widget.sheetId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox tabReview(String text) {
  return SizedBox(
    width: 70,
    child: Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Regular16px(text: text),
          const Icon(
            Icons.star,
            color: AppColors.warning300,
            size: 14,
          )
        ],
      ),
    ),
  );
}
