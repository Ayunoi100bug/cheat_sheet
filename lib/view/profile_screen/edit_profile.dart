import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  const EditProfile({super.key, @PathParam() required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is edit profile page. and your ID is ' + widget.userId),
    );
  }
}
