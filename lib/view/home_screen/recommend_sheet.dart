import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/components/sheet.dart';
import '../../view_model/knn.dart';

class RecommendSheet extends StatefulWidget {
  const RecommendSheet({super.key});

  @override
  State<RecommendSheet> createState() => _ReccommendSheetState();
}

class _ReccommendSheetState extends State<RecommendSheet> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late Future<List<String>> recommendSheetId;

  void initState() {
    super.initState();
    _loadRecommendSheetId();
  }

  Future<void> _loadRecommendSheetId() async {
    recommendSheetId = UpdateRecommendSheet.callRecommendSheet(9);
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
