// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';

import 'package:cheat_sheet/view/profile_screen/profile_sub_page/my_sheet.dart';
import 'package:cheat_sheet/view/profile_screen/profile_sub_page/buy_sheet.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController tabController;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '');

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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    String newUsername;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection("users")
                    .doc(_auth.currentUser?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("This is login, but data is not load"),
                    );
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
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
                                    Container(
                                      width: double.infinity,
                                      height: screenWidth < 480
                                          ? screenHeight * GapDimension.h0_18
                                          : screenHeight * GapDimension.h0_36,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Row(
                                            children: <Widget>[
                                              Container(
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
                                                        image: AssetImage(data[
                                                            'profileImage']),
                                                        // fit: BoxFit.fill,
                                                      ),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .black800,
                                                          width: 2.0),
                                                      shape: BoxShape.circle,
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
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    content:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          screenHeight *
                                                                              0.4,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                screenHeight * 0.2,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: AssetImage(data['profileImage']),
                                                                                // fit: BoxFit.fill,
                                                                              ),
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight * 0.012,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                screenHeight * 0.05,
                                                                            child:
                                                                                InkWell(
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                Icon(FontAwesomeIcons.camera),
                                                                                SizedBox(
                                                                                  width: screenWidth * 0.012,
                                                                                ),
                                                                                Regular12px(text: 'Photo')
                                                                              ]),
                                                                              onTap: () {},
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight * 0.012,
                                                                          ),
                                                                          Form(
                                                                            key:
                                                                                _formKey,
                                                                            child: MyTextFormField(
                                                                                hintText: data['username'],
                                                                                validator: RequiredValidator(errorText: 'Please enter new username.'),
                                                                                onSaved: (value) {
                                                                                  users.username = value!;
                                                                                }),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight * 0.012,
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.centerRight,
                                                                            child: PrimaryButton(
                                                                                text: 'เสร็จสิ้น',
                                                                                onPressed: () {
                                                                                  _formKey.currentState!.save();
                                                                                  _firestore.collection('users').doc(data['uid']).update({'username': users.username}).then((value) => print("User Updated")).catchError((error) => print("Failed to update user: $error"));
                                                                                  _formKey.currentState!.reset();
                                                                                  AutoRouter.of(context).pop();
                                                                                }),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
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
