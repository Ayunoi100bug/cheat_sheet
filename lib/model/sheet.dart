import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Sheets {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String sheetName;
  String detailSheet;
  String sheetCoverImage;
  List<int> demoPages;
  String sid = uuid.v4();
  bool sheetTypeFree;
  int? price;
  int buyer = 0;
  String authorId;
  List? review = [];

  Sheets({
    required this.sheetName,
    required this.detailSheet,
    required this.sheetCoverImage,
    required this.demoPages,
    required this.sheetTypeFree,
    this.price,
    required this.authorId,
  });

  Sheets.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        sheetName = json['sheetName'],
        detailSheet = json['detailSheet'],
        sheetCoverImage = json['sheetCoverImage'],
        demoPages = json["demoPages"],
        sid = json['sid'],
        sheetTypeFree = json['sheetType'],
        price = json['price'],
        buyer = json['buyer'],
        authorId = json['authorId'],
        review = json['review'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'sheetName': sheetName,
        'detailSheet': detailSheet,
        'sheetCoverImage': sheetCoverImage,
        'demoPages': demoPages,
        'sid': sid,
        'sheetTypeFree': sheetTypeFree,
        'price': price,
        'buyer': buyer,
        'authorId': authorId,
        'review': review,
      };
}
