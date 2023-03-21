import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String aid = uuid.v4();
  String text;
  String sheetId;
  String respondentId;
  int? like = 0;
  int? dislike = 0;

  AnswerModel({
    required this.text,
    required this.sheetId,
    required this.respondentId,
    this.like,
    this.dislike,
  });

  AnswerModel.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        aid = json['aid'],
        text = json['text'],
        sheetId = json['sheetId'],
        respondentId = json['respondentId'],
        like = json['like'],
        dislike = json['dislike'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'aid': aid,
        'text': text,
        'sheetId': sheetId,
        'respondentId': respondentId,
        'like': like,
        'dislike': dislike,
      };
}
