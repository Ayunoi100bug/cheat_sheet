import 'package:cloud_firestore/cloud_firestore.dart';

class SheetLists {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String sheetListName;
  String sheetListId;
  List? sid;
  String authorId;

  SheetLists({
    required this.sheetListName,
    required this.sid,
    required this.authorId,
    required this.sheetListId,
  });

  SheetLists.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        sheetListName = json['sheetListName'],
        sid = json['sid'],
        authorId = json['authorId'],
        sheetListId = json['sheetListId'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'sheetListName': sheetListName,
        'sid': sid,
        'authorId': authorId,
        'sheetListId': sheetListId,
      };
}
