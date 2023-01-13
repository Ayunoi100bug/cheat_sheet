import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/achievement.dart';
import 'package:cheat_sheet/res/components/diary_quest.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

import '../res/components/custom_appbar.dart';
import '../res/components/sidebar_menu.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with AutomaticKeepAliveClientMixin {
      

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: screenHeight*0.04,),
            Row(
              children: [
                SizedBox(width: screenWidth*0.04,),
                Medium20px(text: 'เควสประจำวัน'),
                SizedBox(
                  width: screenWidth*0.02,
                ),
                Regular14px(text: 'เหลือ 20 ชม.'),
              ],
            ),
            SizedBox(height: screenHeight*0.01),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                childAspectRatio: screenWidth < 480 ?
                    MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12) : MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 4),
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return DiaryQuest(
                  questName: 'อ่านชีทครบ 3 ครั้ง',
                  completeTime: 3,
                  doingTime: 1,
                  recievePoint: 10,
                );
              },
              padding: EdgeInsets.only(right: screenWidth*0.04, left: screenWidth*0.04),
            ),
            SizedBox(height: screenHeight*0.02,),
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Medium20px(text: 'ความสำเร็จ'),
                  Medium14px(text: 'ดูทั้งหมด', underline: true, color: AppColors.blue700,),
                ],
              ),
            ),
            SizedBox(height: screenHeight*0.01),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                childAspectRatio: screenWidth < 480 ?
                    MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12) : MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 4),
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Achievement(
                  achievementName: 'เข้าสู่ระบบครบ 15 วัน',
                  completeTime: 15,
                  doingTime: 3,
                  recievePoint: 100,
                );
              },
              padding: EdgeInsets.only(right: screenWidth*0.04, left: screenWidth*0.04),
            ),
            SizedBox(height: screenHeight*0.02,),
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Medium20px(text: 'ล่าสุด'),
                  Regular14px(text: 'ดูทั้งหมด', underline: true, color: AppColors.blue700,),
                ],
              ),
            ),
            SizedBox(height: screenHeight*0.02,),
            GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: screenWidth < 480 ?
                        MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.1) : MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 0.4),
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Sheet();
                  },
                  padding: EdgeInsets.only(bottom: screenHeight*0.04, left: screenWidth*0.04, right: screenWidth*0.04),
                ),
          ]),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
