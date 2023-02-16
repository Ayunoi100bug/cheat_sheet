import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SheetListDetail extends StatefulWidget {
  final String sheetId;
  const SheetListDetail({super.key, @pathParam required this.sheetId});

  @override
  State<SheetListDetail> createState() => _SheetListDetailState();
}

class _SheetListDetailState extends State<SheetListDetail> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("sheetList").doc(widget.sheetId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            List sheetInList = data['sid'];
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.038),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isPortrait ? 3 : 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    mainAxisExtent: isPortrait ? 200 : 250,
                  ),
                  itemCount: sheetInList.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: _firestore.collection("sheet").doc(sheetInList[index]).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> sheetSnapshot) {
                        if (!sheetSnapshot.hasData || sheetSnapshot.data!.data() == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return StreamBuilder<DocumentSnapshot>(
                              stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return Container();
                                } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Sheet(
                                    authorImage: userSnapshot.data?['profileImage'],
                                    title: sheetSnapshot.data?["sheetName"],
                                    priceSheet: sheetSnapshot.data?["price"],
                                    username: userSnapshot.data?["username"],
                                    sheetId: sheetSnapshot.data?["sid"],
                                  );
                                }
                              });
                        }
                      },
                    );
                  },
                  padding: const EdgeInsets.only(bottom: 8),
                ),
              ),
            );
          }
        });
  }
}
