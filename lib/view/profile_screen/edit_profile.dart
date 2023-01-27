import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Users users =
      Users(username: '', password: '', email: '', uid: '', profileImage: '');
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _pickedImage;
  String? urlImage;

  Future<void> uploadImage() async {
    Reference ref = storage
        .ref()
        .child('${_auth.currentUser?.uid}/images')
        .child('profileImage');
    await ref.putFile(_pickedImage!);

    urlImage = await ref.getDownloadURL();

    await _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .update({'profileImage': urlImage});
  }

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
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
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection("users")
                    .doc(_auth.currentUser?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("This is login, but data is not load"),
                    );
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Scaffold(
                      body: SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: isPortrait
                                  ? screenHeight * 0.016
                                  : screenWidth * 0.016),
                          width: double.infinity,
                          height:
                              isPortrait ? screenHeight * 0.5 : double.infinity,
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: isPortrait
                                      ? screenHeight * 0.2
                                      : screenWidth * 0.2,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.black300,
                                  ),
                                  child: _pickedImage == null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              data['profileImage']),
                                          radius: 100.0,
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              FileImage(_pickedImage!),
                                          radius: 100.0,
                                        ),
                                ),
                                SizedBox(
                                  height: isPortrait
                                      ? screenHeight * 0.012
                                      : screenWidth * 0.012,
                                ),
                                SizedBox(
                                  height: isPortrait
                                      ? screenHeight * 0.05
                                      : screenWidth * 0.05,
                                  child: InkWell(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(FontAwesomeIcons.camera),
                                          SizedBox(
                                            width: screenWidth * 0.012,
                                          ),
                                          const Regular12px(
                                              text: 'เลือกรูปภาพ'),
                                        ]),
                                    onTap: () {
                                      _pickImage();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: isPortrait
                                      ? screenHeight * 0.012
                                      : screenWidth * 0.012,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: isPortrait
                                          ? screenWidth * 0.45
                                          : screenHeight * 0.45),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Medium16px(text: 'ชื่อ'),
                                  ),
                                ),
                                SizedBox(
                                  width: isPortrait
                                      ? screenWidth * 0.5
                                      : screenHeight * 0.5,
                                  child: Form(
                                    key: _formKey,
                                    child: MyTextFormField(
                                        hintText: data['username'],
                                        validator: RequiredValidator(
                                            errorText:
                                                'Please enter new username.'),
                                        onSaved: (value) {
                                          users.username = value!;
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: isPortrait
                                      ? screenHeight * 0.016
                                      : screenWidth * 0.016,
                                ),
                                PrimaryButton(
                                    text: 'เสร็จสิ้น',
                                    onPressed: () {
                                      uploadImage();
                                      _formKey.currentState!.save();
                                      _firestore
                                          .collection('users')
                                          .doc(data['uid'])
                                          .update({
                                            'username': users.username,
                                          })
                                          .then(
                                              (value) => print("User Updated"))
                                          .catchError((error) => print(
                                              "Failed to update user: $error"));
                                      _formKey.currentState!.reset();
                                      AutoRouter.of(context).pop();
                                    }),
                                SizedBox(
                                  height: isPortrait
                                      ? screenHeight * 0.016
                                      : screenWidth * 0.016,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                });
          } else {
            return const Center(
              child: Text("This is page when not login"),
            );
          }
        });
  }
}
