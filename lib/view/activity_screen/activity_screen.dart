import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/achievement.dart';
import 'package:cheat_sheet/res/components/daily_quest.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/components/popup_auth.dart';

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
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (_auth.currentUser == null) {
      return Popup_Login(context);
    }
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
          if (!userSnapshot.hasData) {
            return Container();
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
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
                        horizontal: isPortrait ? screenWidth * 0.04 : screenWidth * 0.06,
                        vertical: isPortrait ? screenWidth * 0.01 : screenWidth * 0.02),
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
                      return StreamBuilder<DocumentSnapshot>(
                          stream: _firestore.collection('dailyQuest').doc(userSnapshot.data!['quest${index + 1}'][1]).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot dailyQuestSnapshot) {
                            if (!dailyQuestSnapshot.hasData) {
                              return Container();
                            } else if (dailyQuestSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return DailyQuest(
                              questName: dailyQuestSnapshot.data!['questName'],
                              completeTime: dailyQuestSnapshot.data!['complete'],
                              doingTime: userSnapshot.data!['quest${index + 1}'][0],
                              recievePoint: dailyQuestSnapshot.data!['point'],
                              success: userSnapshot.data!['quest${index + 1}'][2],
                            );
                          });
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
                            AutoRouter.of(context).push(const AllAchievementRoute());
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection("achievement").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 8,
                            mainAxisExtent: isPortrait ? 70 : 90,
                          ),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Achievement(
                              achievementName: snapshot.data!.docs[index]['achievementName'] +
                                  ' ' +
                                  userSnapshot.data![snapshot.data!.docs[index]['type']][1].toString() +
                                  ' ' +
                                  snapshot.data!.docs[index]['achievementLastName'],
                              completeTime: userSnapshot.data![snapshot.data!.docs[index]['type']][1],
                              doingTime: userSnapshot.data![snapshot.data!.docs[index]['type']][0],
                              recievePoint: userSnapshot.data![snapshot.data!.docs[index]['type']][2],
                              success: userSnapshot.data![snapshot.data!.docs[index]['type']][3],
                            );
                          },
                          padding: EdgeInsets.only(right: screenWidth * 0.04, left: screenWidth * 0.04),
                        );
                      }),
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
                        rating: 4.5,
                        authorImage:
                            'https://firebasestorage.googleapis.com/v0/b/cheatsheet-770ad.appspot.com/o/users%2F8om0U6KH5RhmdU3pFUAatocw3Mm2%2Fimages%2FprofileImage?alt=media&token=e1222c57-38ef-4d2b-8840-8d70d8745651',
                        title: 'สถิติพื้นฐานooooooooooo',
                        priceSheet: 0,
                        username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
                        sheetId: (index + 1).toString(),
                        sheetCoverImage:
                            'https://firebasestorage.googleapis.com/v0/b/cheatsheet-770ad.appspot.com/o/sheets%2Fcd4d0717-7ec0-4e96-b27c-ac27efb8b809%2Fcover_image.png?alt=media&token=67c954eb-1297-4cf4-846c-e58b86b536cc',
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
                        rating: 4.5,
                        authorImage: 'https://lh3.googleusercontent.com/a/AEdFTp52DCit4mYX_ZfFy1B7gh6MPgwsznDxzYha9_kTJg=s96-c',
                        title: 'สถิติพื้นฐานooooooooooo',
                        priceSheet: 0,
                        username: 'Macaronnnnnnnnnnnnnnnnnnnnnn',
                        sheetId: (index + 1).toString(),
                        sheetCoverImage:
                            'https://firebasestorage.googleapis.com/v0/b/cheatsheet-770ad.appspot.com/o/sheets%2Fcd4d0717-7ec0-4e96-b27c-ac27efb8b809%2Fcover_image.png?alt=media&token=67c954eb-1297-4cf4-846c-e58b86b536cc',
                      );
                    },
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02, left: screenWidth * 0.04, right: screenWidth * 0.04),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
