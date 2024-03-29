import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  const EditProfile({super.key, @PathParam() required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '', profileImage: '', subject: []);
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _pickedImage;
  String? urlImage;

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: const Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: const Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker().pickImage(source: imageSource);
      if (file != null) {
        File? img = File(file.path);
        setState(() {
          _pickedImage = img;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("This is page when not login"),
            );
          }
          return StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  body: SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(top: isPortrait ? screenHeight * 0.016 : screenWidth * 0.016),
                      width: double.infinity,
                      height: isPortrait ? screenHeight * 0.5 : double.infinity,
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: isPortrait ? screenHeight * 0.2 : screenWidth * 0.2,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.black300,
                              ),
                              child: _pickedImage == null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(data['profileImage']),
                                      radius: 100.0,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_pickedImage!),
                                      radius: 100.0,
                                    ),
                            ),
                            SizedBox(
                              height: isPortrait ? screenHeight * 0.012 : screenWidth * 0.012,
                            ),
                            SizedBox(
                              height: isPortrait ? screenHeight * 0.05 : screenWidth * 0.05,
                              child: InkWell(
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  const Icon(FontAwesomeIcons.camera),
                                  SizedBox(
                                    width: screenWidth * 0.012,
                                  ),
                                  const Regular12px(text: 'เลือกรูปภาพ'),
                                ]),
                                onTap: () {
                                  _pickImage();
                                },
                              ),
                            ),
                            SizedBox(
                              height: isPortrait ? screenHeight * 0.012 : screenWidth * 0.012,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: isPortrait ? screenWidth * 0.45 : screenHeight * 0.45),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Medium16px(text: 'ชื่อ'),
                              ),
                            ),
                            SizedBox(
                              width: isPortrait ? screenWidth * 0.5 : screenHeight * 0.5,
                              child: Form(
                                key: _formKey,
                                child: MyTextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    hintText: data['username'],
                                    validator: RequiredValidator(errorText: 'กรุณากรอก username ใหม่ของท่าน.'),
                                    onSaved: (value) {
                                      if (value == '') {
                                        users.username = data['username'];
                                      } else {
                                        users.username = value!;
                                      }
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: isPortrait ? screenHeight * 0.016 : screenWidth * 0.016,
                            ),
                            PrimaryButton(
                                text: 'เสร็จสิ้น',
                                onPressed: () async {
                                  EditProfileData().uploadImage(_pickedImage);
                                  _formKey.currentState!.save();
                                  await EditProfileData().editUserName(context, data['uid'], users.username).then((value) {
                                    _formKey.currentState!.reset();
                                  });
                                }),
                            SizedBox(
                              height: isPortrait ? screenHeight * 0.016 : screenWidth * 0.016,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
