import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../res/components/sheet.dart';
import '../../../res/gap_dimension.dart';

class MySheet extends StatelessWidget {
  MySheet({super.key});
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("sheet").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final mySheets = snapshot.data!.docs.where((document) => document["authorId"] == _auth.currentUser?.uid);
          return Padding(
            padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 3 : 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                mainAxisExtent: isPortrait ? 200 : 250,
              ),
              itemCount: mySheets.length,
              itemBuilder: (context, index) {
                var sheet = mySheets.elementAt(index);
                if (sheet["authorId"] != _auth.currentUser?.uid) {
                  return Container();
                }
                return StreamBuilder<DocumentSnapshot>(
                    stream: _firestore.collection("users").doc(sheet["authorId"]).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                      if (!userSnapshot.hasData) {
                        return Container();
                      } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Sheet(
                        rating: sheet["rating"],
                        sheetCoverImage: sheet["sheetCoverImage"],
                        authorImage: userSnapshot.data?["profileImage"],
                        title: sheet["sheetName"],
                        priceSheet: sheet["price"],
                        username: userSnapshot.data?["username"],
                        sheetId: sheet["sid"],
                      );
                    });
              },
            ),
          );
        });
  }
}
