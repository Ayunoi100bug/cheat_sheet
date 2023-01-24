class Users {
  String username;
  String email;
  String password;
  String uid;
  String profileImage;
  int follower = 0;
  int following = 0;

  Users({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.profileImage
  });

  Users.fromJson(Map<String, dynamic> json)
    : username = json['username'],
    email = json['email'],
    password = json['password'],
    uid = json['uid'],
    profileImage = json['profileImage'],
    follower = json['follower'],
    following = json['following'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'uid': uid,
    'profileImage': profileImage,
    'follower': follower,
    'following': following,
  };
}
