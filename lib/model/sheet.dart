import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Sheets {
  String sheetName;
  String detailSheet;
  String sid = uuid.v1();
  bool sheetTypeFree;
  int? price;
  String authorId;

  Sheets({
    required this.sheetName,
    required this.detailSheet,
    required this.sheetTypeFree,
    this.price,
    required this.authorId,
  });

  Sheets.fromJson(Map<String, dynamic> json)
      : sheetName = json['sheetName'],
        detailSheet = json['detailSheet'],
        sid = json['sid'],
        sheetTypeFree = json['sheetType'],
        price = json['price'],
        authorId = json['authorId'];

  Map<String, dynamic> toJson() => {
        'sheetName': sheetName,
        'detailSheet': detailSheet,
        'sid': sid,
        'sheetTypeFree': sheetTypeFree,
        'price': price,
        'uid': authorId,
      };
}
