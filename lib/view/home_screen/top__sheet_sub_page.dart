import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/components/sheet.dart';

class TopSheetSubPage extends StatefulWidget {
  final String tagName;
  const TopSheetSubPage({super.key, required this.tagName});

  @override
  State<TopSheetSubPage> createState() => _TopSheetSubPageState();
}

class _TopSheetSubPageState extends State<TopSheetSubPage> {
  final _firestore = FirebaseFirestore.instance;
  late List sortLikeSheet = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection("tag").doc(widget.tagName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> tagSnapshot) {
        if (!tagSnapshot.hasData) {
          return Container();
        } else if (tagSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> tagData = tagSnapshot.data!.data() as Map<String, dynamic>;
        List<dynamic> tagList = tagData['sheetInTagList'];
        List subList = tagList.take(10).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("sheet").where('sid', whereIn: subList).snapshots(),
          builder: (context, sheetSnapshot) {
            if (!sheetSnapshot.hasData) {
              return Container();
            } else if (sheetSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            for (int i = 0; i < subList.length; i++) {
              Map<String, dynamic> sheet = sheetSnapshot.data?.docs[i].data() as Map<String, dynamic>;
              sortLikeSheet.add(sheet);
            }
            sortLikeSheet.sort((a, b) => b['likeAmount'].compareTo(a['likeAmount']));

            return SingleChildScrollView(
              child: Column(
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
                      itemCount: sortLikeSheet.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: _firestore.collection("users").doc(sortLikeSheet[index]['authorId']).snapshots(),
                          builder: (context, userSnapshot) {
                            if (!userSnapshot.hasData) {
                              return Container();
                            } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Sheet(
                              rating: sortLikeSheet[index]["rating"],
                              sheetCoverImage: sortLikeSheet[index]["sheetCoverImage"],
                              authorImage: userSnapshot.data?["profileImage"],
                              title: sortLikeSheet[index]["sheetName"],
                              priceSheet: sortLikeSheet[index]["price"],
                              username: userSnapshot.data?["username"],
                              sheetId: sortLikeSheet[index]["sid"],
                            );
                          },
                        );
                      },
                      padding: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
