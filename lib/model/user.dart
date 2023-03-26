import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  FieldValue timestamp = FieldValue.serverTimestamp();
  FieldValue lastDayLogin = FieldValue.serverTimestamp();
  String username;
  String email;
  String password;
  String uid;
  String profileImage;
  int follower = 0;
  int following = 0;
  int coin = 0;
  List quest1 = [0, '', false];
  List quest2 = [0, '', false];
  List quest3 = [0, '', false];
  List trackingAsk = [0, 5, 15, false];
  List trackingBuySheet = [0, 5, 15, false];
  List trackingCreateSheetList = [0, 5, 15, false];
  List trackingLike = [0, 5, 15, false];
  List trackingLogin = [0, 5, 15, false];
  List trackingReadSheet = [0, 5, 15, false];
  List trackingReview = [0, 5, 15, false];
  List? sheetLists = [];
  List? buyedSheet = [];

  Users({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.profileImage,
  });

  Users.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        lastDayLogin = json['lastDayLogin'],
        username = json['username'],
        email = json['email'],
        password = json['password'],
        uid = json['uid'],
        profileImage = json['profileImage'],
        follower = json['follower'],
        following = json['following'],
        coin = json['coin'],
        quest1 = json['quest1'],
        quest2 = json['quest2'],
        quest3 = json['quest3'],
        trackingAsk = json['trackingAsk'],
        trackingBuySheet = json['trackingBuySheet'],
        trackingCreateSheetList = json['trackingCreateSheetList'],
        trackingLike = json['trackingLike'],
        trackingLogin = json['trackingLogin'],
        trackingReadSheet = json['trackingReadSheet'],
        trackingReview = json['trackingReview'],
        sheetLists = json['sheetList'],
        buyedSheet = json['buyedSheet'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'lastDayLogin': lastDayLogin,
        'username': username,
        'email': email,
        'password': password,
        'uid': uid,
        'profileImage': profileImage,
        'follower': follower,
        'following': following,
        'coin': coin,
        'quest1': quest1,
        'quest2': quest2,
        'quest3': quest3,
        'trackingAsk': trackingAsk,
        'trackingBuySheet': trackingBuySheet,
        'trackingCreateSheetList': trackingCreateSheetList,
        'trackingLike': trackingLike,
        'trackingLogin': trackingLogin,
        'trackingReadSheet': trackingReadSheet,
        'trackingReview': trackingReview,
        'sheetLists': sheetLists,
      };
}
