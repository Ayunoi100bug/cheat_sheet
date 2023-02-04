import 'package:auto_route/auto_route.dart';

import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/gap_dimension.dart';
import '../../res/typo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("sheet").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final int documentCount = snapshot.data!.docs.length;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     AutoRouter.of(context).push(const TestUIRoute());
                    //   },
                    //   child: const Text('กด ตรงนี้ นะ บุ๊คคค'),
                    // ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.secondary800,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: AppColors.secondary800,
                            ),
                            Light20px(
                              text: 'Search',
                              color: AppColors.primary600,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
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
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
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
                            stream: _firestore
                                .collection("users")
                                .doc(sheet?["uid"])
                                .snapshots(),
                            builder: (context, userSnapshot) {
                              if (!userSnapshot.hasData ||
                                  userSnapshot.data!.data() == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Sheet(
                                  authorImage:
                                      userSnapshot.data?["profileImage"],
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
