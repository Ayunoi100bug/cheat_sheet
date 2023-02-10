import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  FieldValue timestamp = FieldValue.serverTimestamp();
  String username;
  String email;
  String password;
  String uid;
  String profileImage;
  int follower = 0;
  int following = 0;
  int coin = 0;
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
        username = json['username'],
        email = json['email'],
        password = json['password'],
        uid = json['uid'],
        profileImage = json['profileImage'],
        follower = json['follower'],
        following = json['following'],
        coin = json['coin'],
        sheetLists = json['sheetList'],
        buyedSheet = json['buyedSheet'];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'username': username,
        'email': email,
        'password': password,
        'uid': uid,
        'profileImage': profileImage,
        'follower': follower,
        'following': following,
        'coin': coin,
        'sheetLists': sheetLists,
      };
}
