import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/components/achievement.dart';
import '../../res/components/popup_auth.dart';

class AllAchievement extends StatefulWidget {
  const AllAchievement({super.key});

  @override
  State<AllAchievement> createState() => _AllAchievementState();
}

class _AllAchievementState extends State<AllAchievement> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return Container();
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_auth.currentUser == null) {
            return Popup_Login(context);
          }
          return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("achievement").snapshots(),
              builder: (context, snapshot) {
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
                  itemCount: snapshot.data!.docs.length,
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
              });
        });
  }
}
