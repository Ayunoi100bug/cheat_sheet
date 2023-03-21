import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String ansid = uuid.v4();
  String text;
  String respondentId;
  int? like = 0;

  AnswerModel({
    required this.text,
    required this.respondentId,
    this.like,
  });

  AnswerModel.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        ansid = json['ansid'],
        text = json['text'],
        respondentId = json['respondentId'],
        like = json['like'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'ansid': ansid,
        'text': text,
        'respondentId': respondentId,
        'like': like,
      };
}
