import 'package:uuid/uuid.dart';
class Users {
  String username;
  String email;
  String password;
  String uid;
  String profileImage = "assets/images/default_profile.png";

  Users({required this.username,required this.email,required this.password, required this.uid}) {
    uid = const Uuid().v4();
  }
}