import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/knn.dart';
import 'package:cheat_sheet/view_model/read_firestore.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/typo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    DateTime thisDay = DateTime.now();
    UpdateCollection().updateUserDay(context, thisDay, _auth.currentUser?.uid);

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("sheet").orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final int documentCount = snapshot.data!.docs.length;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Data a = Data(sheetId: 'a', tagNameList: ['คณิต']);
                          Data b = Data(sheetId: 'b', tagNameList: ['คณิต', 'ไทย']);
                          Data c = Data(sheetId: 'c', tagNameList: ['คณิต']);
                          Data d = Data(sheetId: 'd', tagNameList: []);
                          KNN.addDataTolist(b);
                          KNN.addDataTolist(c);
                          KNN.addDataTolist(d);
                          KNN.caculateSimilarity(a);
                          // KNN.displayData();
                          // KNN.displaySimilarity();
                        },
                        child: const Text('เพิ่ม Data')),
                    ElevatedButton(
                        onPressed: () {
                          KNN.resetKNN();
                        },
                        child: Text('เคลีย KNN')),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) => Popup_DeleteAllSheet(context),
                    //     );
                    //   },
                    //   child: const Text("ปุ่มลบชีททั้งหมด"),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        var temp3 = await ReadCollection().getAllSheetExceptCurrentUserWithoutLiked();
                        debugPrint("Result: ${temp3.length}");
                      },
                      child: const Text("test"),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                          width: screenWidth,
                          height: isPortrait ? screenWidth * 0.13 : screenWidth * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary800),
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.black200,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: AppColors.primary800,
                                size: 18,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Regular16px(
                                text: 'Search',
                                color: Colors.grey,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          AutoRouter.of(context).push(const SearchingSheetRoute());
                        },
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
                              }
                              return FutureBuilder<Map<String, dynamic>>(
                                  future: ReadCollection().getCurrentUserData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Map<String, dynamic> currentUserData = snapshot.data!;
                                      return Sheet(
                                        rating: sheet?["rating"],
                                        sheetCoverImage: sheet?["sheetCoverImage"],
                                        authorImage: userSnapshot.data?["profileImage"],
                                        title: sheet?["sheetName"],
                                        priceSheet: sheet?["price"],
                                        username: userSnapshot.data?["username"],
                                        sheetId: sheet?["sid"],
                                        currentUserData: currentUserData,
                                      );
                                    }
                                    return Sheet(
                                      rating: sheet?["rating"],
                                      sheetCoverImage: sheet?["sheetCoverImage"],
                                      authorImage: userSnapshot.data?["profileImage"],
                                      title: sheet?["sheetName"],
                                      priceSheet: sheet?["price"],
                                      username: userSnapshot.data?["username"],
                                      sheetId: sheet?["sid"],
                                    );
                                  });
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
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
