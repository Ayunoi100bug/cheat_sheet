import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/achievement.dart';
import 'package:cheat_sheet/res/components/diary_quest.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? screenWidth * 0.04 : screenWidth * 0.06, vertical: isPortrait ? screenWidth * 0.01 : screenWidth * 0.02),
              child: Row(
                children: [
                  const Medium20px(text: 'เควสประจำวัน'),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  const Regular14px(text: 'เหลือ 20 ชม.'),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                mainAxisExtent: isPortrait ? 70 : 90,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const DiaryQuest(
                  questName: 'อ่านชีทครบ 3 ครั้ง',
                  completeTime: 3,
                  doingTime: 1,
                  recievePoint: 10,
                );
              },
              padding: EdgeInsets.only(right: screenWidth * 0.04, left: screenWidth * 0.04),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isPortrait ? screenWidth * 0.04 : screenWidth * 0.06, vertical: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Medium20px(text: 'ความสำเร็จ'),
                  InkWell(
                    child: const Medium14px(
                      text: 'ดูทั้งหมด',
                      underline: true,
                      color: AppColors.blue700,
                    ),
                    onTap: () {
                      print("show all achievements page");
                    },
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                mainAxisExtent: isPortrait ? 70 : 90,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Achievement(
                  achievementName: 'เข้าสู่ระบบครบ 15 วัน',
                  completeTime: 15,
                  doingTime: 3,
                  recievePoint: 100,
                );
              },
              padding: EdgeInsets.only(right: screenWidth * 0.04, left: screenWidth * 0.04),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Medium20px(text: 'ล่าสุด'),
                  InkWell(
                    child: const Regular14px(
                      text: 'ดูทั้งหมด',
                      underline: true,
                      color: AppColors.blue700,
                    ),
                    onTap: () {
                      print("show all last page");
                    },
                  )
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 3 : 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                mainAxisExtent: isPortrait ? 180 : 210,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Sheet(
                  authorImage:
                      'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10224779237682961&width=200&ext=1678426745&hash=AeSupq2Xh_IJA7iaWys',
                  title: 'สถิติพื้นฐานooooooooooo',
                  priceSheet: 0,
                  username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
                  sheetId: (index + 1).toString(),
                  sheetCoverImage: '',
                );
              },
              padding: EdgeInsets.only(bottom: screenHeight * 0.02, left: screenWidth * 0.04, right: screenWidth * 0.04),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Medium20px(text: 'ดาวน์โหลด'),
                  InkWell(
                    child: const Regular14px(
                      text: 'ดูทั้งหมด',
                      underline: true,
                      color: AppColors.blue700,
                    ),
                    onTap: () {
                      print("show all downloads page");
                    },
                  )
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 3 : 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                mainAxisExtent: isPortrait ? 180 : 210,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Sheet(
                  authorImage:
                      'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10224779237682961&width=200&ext=1678426745&hash=AeSupq2Xh_IJA7iaWys',
                  title: 'สถิติพื้นฐานooooooooooo',
                  priceSheet: 0,
                  username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
                  sheetId: (index + 1).toString(),
                  sheetCoverImage: '',
                );
              },
              padding: EdgeInsets.only(bottom: screenHeight * 0.02, left: screenWidth * 0.04, right: screenWidth * 0.04),
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
