import 'package:auto_route/auto_route.dart';

import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/popup_dialog.dart';
import 'package:cheat_sheet/res/components/popup_login.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/searching_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/components/popup_create_tag.dart';
import '../../res/gap_dimension.dart';
import '../../res/typo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("sheet").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final int documentCount = snapshot.data!.docs.length;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Popup_DeleteSheet(context),
                          );
                        },
                        child: const Text("ปุ่มลบชีททั้งหมด")),
                    ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const SearchingSheetRoute());
                        },
                        child: const Text('ปุ่มไปหน้าค้นหาชั่วคราว')),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Popup_DeleteSheet(context),
                        );
                      },
                      child: const Text('Popup Dialog'),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Popup_Login(context),
                        );
                      },
                      child: const Text('Popup Login'),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Popup_CreateTag(context),
                        );
                      },
                      child: const Text('Popup Create Tag'),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                      child: TextField(
                        cursorColor: AppColors.black900,
                        decoration: InputDecoration(
                            isDense: true,
                            fillColor: AppColors.black200,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50), borderSide: BorderSide(width: 1, color: AppColors.primary800)),
                            hintText: 'Search',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50), borderSide: BorderSide(width: 1, color: AppColors.primary800)),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(
                                Icons.search,
                                color: AppColors.primary800,
                              ),
                              width: 18,
                            )),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ).copyWith(right: 0),
                      child: Row(
                        children: const [
                          Medium20px(text: 'ชีทแนะนำสำหรับคุณ'),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isPortrait ? 3 : 5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          mainAxisExtent: isPortrait ? 200 : 250,
                        ),
                        itemCount: documentCount,
                        itemBuilder: (context, index) {
                          var sheet = snapshot.data?.docs[index];
                          return StreamBuilder<DocumentSnapshot>(
                            stream: _firestore.collection("users").doc(sheet?["authorId"]).snapshots(),
                            builder: (context, userSnapshot) {
                              if (!userSnapshot.hasData) {
                                return Container();
                              } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Sheet(
                                  authorImage: userSnapshot.data?["profileImage"],
                                  title: sheet?["sheetName"],
                                  priceSheet: sheet?["price"],
                                  username: userSnapshot.data?["username"],
                                  sheetId: sheet?["sid"],
                                );
                              }
                            },
                          );
                        },
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
