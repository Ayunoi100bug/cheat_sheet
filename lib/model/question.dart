import 'package:cheat_sheet/view/sheet_list_screen/sheet_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String qid = uuid.v4();
  String text;
  String sheetId;
  String questionerId;
  int askingPage;
  List? answer = [];

  Question({
    required this.text,
    required this.sheetId,
    required this.questionerId,
    required this.askingPage,
  });

  Question.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        qid = json['qid'],
        text = json['text'],
        sheetId = json['sheetId'],
        questionerId = json['questionerId'],
        askingPage = json['askingPage'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'qid': qid,
        'text': text,
        'sheetId': sheetId,
        'questionerId': questionerId,
        'askingPage': askingPage,
      };
}
