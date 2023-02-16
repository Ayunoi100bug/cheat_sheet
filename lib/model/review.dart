import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String rid;
  String text;
  String authorId;
  String sheetId;
  double rating;
  int? like = 0;

  Reviews({
    required this.rid,
    required this.text,
    required this.authorId,
    required this.sheetId,
    required this.rating,
    this.like,
  });

  Reviews.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        rid = json['rid'],
        text = json['text'],
        authorId = json['authorId'],
        sheetId = json['sheetId'],
        rating = json['rating'],
        like = json['like'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'rid': rid,
        'text': text,
        'authorId': authorId,
        'sheetId': sheetId,
        'rating': rating,
        'like': like,
      };
}
