import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/my_sheet.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/buy_sheet.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
  with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController tabController;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '');
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Scaffold(
                      body: SafeArea(
                        child: DefaultTabController(
                          length: 2,
                          child: NestedScrollView(
                            scrollDirection: Axis.vertical,
                            headerSliverBuilder:
                                (context, innerBoxIsScrolled) => [
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: screenWidth < 480
                                          ? screenHeight * GapDimension.h0_18
                                          : screenHeight * GapDimension.h0_36,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: constraints.maxWidth *
                                                    GapDimension.w0_4,
                                                height: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      constraints.maxHeight *
                                                          GapDimension.h0_12),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: CachedNetworkImageProvider(data['profileImage']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .black800,
                                                          width: 2.0),
                                                      shape: BoxShape.circle,
                                                      color: AppColors.black300,
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(data[
                                                              'profileImage']),
                                                      radius: 100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height:
                                                        constraints.maxHeight *
                                                            GapDimension.h0_5,
                                                    width:
                                                        constraints.maxWidth *
                                                            GapDimension.w0_6,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Medium24px(
                                                            text: data[
                                                                'username']),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: AppColors
                                                                .tertiary600,
                                                          ),
                                                          onPressed: () {
                                                            AutoRouter.of(
                                                                    context)
                                                                .push(EditProfileRoute(
                                                                    userId: data[
                                                                        'uid']));
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        constraints.maxHeight *
                                                            GapDimension.h0_5,
                                                    width:
                                                        constraints.maxWidth *
                                                            GapDimension.w0_6,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Medium20px(
                                                                text: data[
                                                                        'follower']
                                                                    .toString()),
                                                            const Regular14px(
                                                                text:
                                                                    "ผู้ติดตาม"),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Medium20px(
                                                                text: data[
                                                                        'following']
                                                                    .toString()),
                                                            const Regular14px(
                                                                text:
                                                                    "กำลังติตดาม"),
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
                                    TabBar(
                                      controller: tabController,
                                      labelStyle: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'BaiJamjuree',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      labelColor: AppColors.primary700,
                                      indicatorWeight: 1,
                                      indicatorColor: AppColors.primary700,
                                      unselectedLabelColor: AppColors.black400,
                                      tabs: const [
                                        Tab(
                                          text: 'ชีทของฉัน',
                                        ),
                                        Tab(
                                          text: 'ชีทที่ซื้อ',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            body: TabBarView(
                              controller: tabController,
                              children: const [
                                MySheet(),
                                BuySheet(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                });
          } else {
            return const Center(
              child: Text("This is page when not login"),
            );
          }
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
