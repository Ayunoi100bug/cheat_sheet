import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cheat_sheet/view_model/knn.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/components/popup_dialog.dart';
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
  late Future<List<String>> recommendSheetId;

  void initState() {
    super.initState();
    _loadRecommendSheetId();
  }

  Future<void> _loadRecommendSheetId() async {
    recommendSheetId = UpdateRecommendSheet.callRecommendSheet(3);
    try {
      List<String> result = await recommendSheetId;
      print(result); // do something with the result
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    DateTime thisDay = DateTime.now();
    if (AuthService().isLogged()) {
      UpdateCollection().updateUserDay(context, thisDay, _auth.currentUser?.uid);
    }

    if (_auth.currentUser?.uid == null) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                  ).copyWith(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Medium20px(text: 'ชีทมาแรง'),
                          Image.asset(
                            'assets/images/fire.png',
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      InkWell(
                        child: const Medium16px(
                          text: 'ดูเพิ่มเติม',
                          color: AppColors.tertiary700,
                          underline: true,
                        ),
                        onTap: () {
                          AutoRouter.of(context).push(TopSheetRoute());
                        },
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("sheet").orderBy('likeAmount', descending: true).limit(3).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final int documentCount = snapshot.data!.docs.length;
                    return Column(
                      children: [
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
                                  return Sheet(
                                    rating: sheet?["rating"],
                                    sheetCoverImage: sheet?["sheetCoverImage"],
                                    authorImage: userSnapshot.data?["profileImage"],
                                    title: sheet?["sheetName"],
                                    priceSheet: sheet?["price"],
                                    username: userSnapshot.data?["username"],
                                    sheetId: sheet?["sid"],
                                  );
                                },
                              );
                            },
                            padding: const EdgeInsets.only(bottom: 8),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Medium20px(text: 'ชีททั้งหมด'),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection("sheet").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final int documentCount = snapshot.data!.docs.length;
                      return Column(
                        children: [
                          SizedBox(
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
                                    return Sheet(
                                      rating: sheet?["rating"],
                                      sheetCoverImage: sheet?["sheetCoverImage"],
                                      authorImage: userSnapshot.data?["profileImage"],
                                      title: sheet?["sheetName"],
                                      priceSheet: sheet?["price"],
                                      username: userSnapshot.data?["username"],
                                      sheetId: sheet?["sid"],
                                    );
                                  },
                                );
                              },
                              padding: const EdgeInsets.only(bottom: 8),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("sheet").orderBy('timestamp', descending: true).limit(3).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) => Popup_DeleteAllSheet(context),
                      //     );
                      //   },
                      //   child: const Text("ปุ่มลบชีททั้งหมด"),
                      // ),
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
                        ).copyWith(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Medium20px(text: 'ชีทแนะนำสำหรับคุณ'),
                            InkWell(
                              child: const Medium16px(
                                text: 'ดูเพิ่มเติม',
                                color: AppColors.tertiary700,
                                underline: true,
                              ),
                              onTap: () {
                                AutoRouter.of(context).push(RecommendSheetRoute());
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                      FutureBuilder<List<String>>(
                          future: recommendSheetId,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final documentCount = snapshot.data!.length;
                            final recommendSheetList = snapshot.data!;
                            return Padding(
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
                                  var sheetId = recommendSheetList[index];
                                  return StreamBuilder<DocumentSnapshot>(
                                    stream: _firestore.collection("sheet").doc(sheetId).snapshots(),
                                    builder: (context, sheetSnapshot) {
                                      if (!sheetSnapshot.hasData) {
                                        return Container();
                                      } else if (sheetSnapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return StreamBuilder<DocumentSnapshot>(
                                        stream: _firestore.collection("users").doc(sheetSnapshot.data?['authorId']).snapshots(),
                                        builder: (context, userSnapshot) {
                                          if (!userSnapshot.hasData) {
                                            return Container();
                                          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          return Sheet(
                                            rating: sheetSnapshot.data?["rating"],
                                            sheetCoverImage: sheetSnapshot.data?["sheetCoverImage"],
                                            authorImage: userSnapshot.data?["profileImage"],
                                            title: sheetSnapshot.data?["sheetName"],
                                            priceSheet: sheetSnapshot.data?["price"],
                                            username: userSnapshot.data?["username"],
                                            sheetId: sheetSnapshot.data?["sid"],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                padding: const EdgeInsets.only(bottom: 8),
                              ),
                            );
                          }),
                      SizedBox(
                        height: screenWidth * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ).copyWith(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Medium20px(text: 'ชีทมาแรง'),
                                // Image.asset(
                                //   'assets/images/fire.png',
                                //   width: 18,
                                //   height: 18,
                                // ),
                              ],
                            ),
                            InkWell(
                              child: const Medium16px(
                                text: 'ดูเพิ่มเติม',
                                color: AppColors.tertiary700,
                                underline: true,
                              ),
                              onTap: () {
                                AutoRouter.of(context).push(TopSheetRoute());
                              },
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection("sheet").orderBy('likeAmount', descending: true).limit(3).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final int documentCount = snapshot.data!.docs.length;
                          return Column(
                            children: [
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
                                        return Sheet(
                                          rating: sheet?["rating"],
                                          sheetCoverImage: sheet?["sheetCoverImage"],
                                          authorImage: userSnapshot.data?["profileImage"],
                                          title: sheet?["sheetName"],
                                          priceSheet: sheet?["price"],
                                          username: userSnapshot.data?["username"],
                                          sheetId: sheet?["sid"],
                                        );
                                      },
                                    );
                                  },
                                  padding: const EdgeInsets.only(bottom: 8),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: screenWidth * 0.02,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _firestore.collection("users").doc(_auth.currentUser!.uid).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (!userSnapshot.hasData) {
                            return Container();
                          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          List<Object> following = List.from(userSnapshot.data!['following']);
                          if (following.isNotEmpty) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 16,
                                  ).copyWith(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Medium20px(text: 'บัญชีที่ติดตาม'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenWidth * 0.04,
                                ),
                                SizedBox(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _firestore.collection("sheet").where('authorId', whereIn: following).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      final int documentCount = snapshot.data!.docs.length;

                                      return Column(
                                        children: [
                                          if (documentCount <= 0) ...[
                                            Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03)),
                                            SizedBox(
                                              height: screenWidth * 0.2,
                                              child: Image.network('https://cdn.onlinewebfonts.com/svg/img_257095.png'),
                                            ),
                                            Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01)),
                                            const Regular16px(text: 'บัญชีที่ติดตามยังไม่มีชีท'),
                                            Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03)),
                                          ] else ...[
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
                                                      return Sheet(
                                                        rating: sheet?["rating"],
                                                        sheetCoverImage: sheet?["sheetCoverImage"],
                                                        authorImage: userSnapshot.data?["profileImage"],
                                                        title: sheet?["sheetName"],
                                                        priceSheet: sheet?["price"],
                                                        username: userSnapshot.data?["username"],
                                                        sheetId: sheet?["sid"],
                                                      );
                                                    },
                                                  );
                                                },
                                                padding: const EdgeInsets.only(bottom: 8),
                                              ),
                                            ),
                                          ]
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: screenWidth * 0.02,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 16,
                                  ).copyWith(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Medium20px(text: 'ชีททั้งหมด'),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: _firestore.collection("sheet").snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      final int documentCount = snapshot.data!.docs.length;

                                      return Column(
                                        children: [
                                          SizedBox(
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: isPortrait ? 3 : 5,
                                                crossAxisSpacing: 12,
                                                mainAxisSpacing: 16,
                                                mainAxisExtent: isPortrait ? 200 : 250,
                                              ),
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                var sheet = snapshot.data?.docs[index];
                                                print(sheet);
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
                                                    return Sheet(
                                                      rating: sheet?["rating"],
                                                      sheetCoverImage: sheet?["sheetCoverImage"],
                                                      authorImage: userSnapshot.data?["profileImage"],
                                                      title: sheet?["sheetName"],
                                                      priceSheet: sheet?["price"],
                                                      username: userSnapshot.data?["username"],
                                                      sheetId: sheet?["sid"],
                                                    );
                                                  },
                                                );
                                              },
                                              padding: const EdgeInsets.only(bottom: 8),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
