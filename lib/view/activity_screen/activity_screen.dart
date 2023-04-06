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
                          itemCount: 5,
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
