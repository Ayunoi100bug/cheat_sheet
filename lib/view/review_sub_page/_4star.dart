import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/components/review.dart';

class FourStar extends StatelessWidget {
  final String sheetId;
  const FourStar({super.key, required this.sheetId});

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("sheet").doc(sheetId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic> sheetData = snapshot.data!.data() as Map<String, dynamic>;
            List? reviewInSheet = sheetData['review'];
            reviewInSheet ??= [];
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reviewInSheet.length,
              itemBuilder: (BuildContext context, index) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: _firestore.collection("review").doc(reviewInSheet![index]).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> reviewSnapshot) {
                      if (!reviewSnapshot.hasData) {
                        return Container();
                      } else if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: _firestore.collection("users").doc(reviewSnapshot.data!['reviewerId']).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userReviewSnapshot) {
                            if (!userReviewSnapshot.hasData) {
                              return Container();
                            } else if (userReviewSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              if (reviewSnapshot.data!['rating'] != 4) return Container();
                              return Review(
                                  userImage: userReviewSnapshot.data!['profileImage'],
                                  userName: userReviewSnapshot.data!['username'],
                                  userRating: reviewSnapshot.data!['rating'],
                                  textReview: reviewSnapshot.data!['text'],
                                  dateTime: reviewSnapshot.data!['timestamp'],
                                  like: reviewSnapshot.data!['like']);
                            }
                          },
                        );
                      }
                    });
              },
            );
          }
        });
  }
}
