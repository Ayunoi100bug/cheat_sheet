import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/other_sheet.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../res/button.dart';
import '../../res/colors.dart';
import '../../res/typo.dart';

class OtherProfile extends StatefulWidget {
  final String userId;
  const OtherProfile({super.key, @PathParam() required this.userId});

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '', profileImage: '');
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("users").doc(widget.userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          _firestore.collection('users').doc(widget.userId).get().then((value) {
            var followerFieldValue = value.data()?['follower'];
            for (var follower in followerFieldValue) {
              if (follower == _auth.currentUser!.uid) {
                isFollowing = true;
                break;
              }
            }
          });
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          List followerData = data['follower'];
          List followingData = data['following'];
          int follower = followerData.length;
          int following = followingData.length;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenWidth < 480 ? screenHeight * 0.24 : screenHeight * 0.48,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              width: constraints.maxWidth * 0.4,
                              height: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(constraints.maxHeight * 0.12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(data['profileImage']),
                                    ),
                                    border: Border.all(color: AppColors.black800, width: 2.0),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: constraints.maxHeight * 0.4,
                                  width: constraints.maxWidth * 0.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Medium24px(text: data['username']),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.3,
                                  width: constraints.maxWidth * 0.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Medium20px(text: "$follower"),
                                          const Regular14px(text: "ผู้ติดตาม"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Medium20px(text: "$following"),
                                          const Regular14px(text: "กำลังติตดาม"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                if (!isFollowing) ...[
                                  PrimaryButton(
                                    text: "ติดตาม",
                                    onPressed: () {
                                      FollowSystem().followUser(_auth.currentUser!.uid, widget.userId);
                                      isFollowing = true;
                                    },
                                  )
                                ] else ...[
                                  PrimaryButton(
                                    text: "เลิกติดตาม",
                                    onPressed: () {
                                      FollowSystem().unfollowUser(_auth.currentUser!.uid, widget.userId);
                                      isFollowing = false;
                                    },
                                  )
                                ]
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenWidth * 0.002,
                    color: AppColors.black500,
                  ),
                  Expanded(
                    child: OtherSheet(
                      userId: widget.userId,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
