import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../res/components/sheet.dart';
import '../../../res/gap_dimension.dart';

class BuySheet extends StatelessWidget {
  BuySheet({super.key});
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("sheet").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final int documentCount = snapshot.data!.docs.length;
            return Padding(
              padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait ? 3 : 5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                  mainAxisExtent: isPortrait ? 200 : 250,
                ),
                itemCount: documentCount,
                itemBuilder: (context, index) {
                  var sheet = snapshot.data?.docs[index];
                  return StreamBuilder<DocumentSnapshot>(
                    stream: _firestore.collection("users").doc(sheet?["uid"]).snapshots(),
                    builder: (context, userSnapshot) {
                      if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
                        return const Center(child: CircularProgressIndicator(),);
                      } else {
                        return Sheet(
                          authorImage: userSnapshot.data?["profileImage"],
                          title: sheet?["sheetName"],
                          priceSheet: sheet?["price"],
                          username: userSnapshot.data?["username"],
                          sheetId: index + 1,
                        );
                      }
                    }
                  );
                },
              ),
            );
          }
        });
  }
}