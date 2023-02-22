import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String qid = uuid.v4();
  String text;
  String sheetId;
  String authorId;
  int askingPage;
  List? answer = [];

  Question({
    required this.text,
    required this.sheetId,
    required this.authorId,
    required this.askingPage,
  });

  Question.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        qid = json['qid'],
        text = json['text'],
        sheetId = json['sheetId'],
        authorId = json['authorId'],
        askingPage = json['askingPage'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'qid': qid,
        'text': text,
        'sheetId': sheetId,
        'authorId': authorId,
        'askingPage': askingPage,
      };
}
