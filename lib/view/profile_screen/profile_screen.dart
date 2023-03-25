import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/my_sheet.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';

import '../../res/components/popup_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '', profileImage: '');
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return Popup_Login(context);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                          height: screenWidth < 480 ? screenHeight * GapDimension.h0_18 : screenHeight * GapDimension.h0_36,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: constraints.maxWidth * GapDimension.w0_4,
                                    height: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.all(constraints.maxHeight * GapDimension.h0_12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(data['profileImage']),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                          color: AppColors.black300,
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage: CachedNetworkImageProvider(data['profileImage']),
                                          radius: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: constraints.maxHeight * GapDimension.h0_5,
                                        width: constraints.maxWidth * GapDimension.w0_6,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Medium24px(text: data['username']),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: AppColors.tertiary600,
                                              ),
                                              onPressed: () {
                                                AutoRouter.of(context).push(EditProfileRoute(userId: data['uid']));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * GapDimension.h0_5,
                                        width: constraints.maxWidth * GapDimension.w0_6,
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
                        const Expanded(
                          child: MySheet(),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
