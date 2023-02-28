import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pdf_render/pdf_render.dart';

import '../../res/button.dart';
import '../../res/colors.dart';
import '../../res/components/form_field.dart';
import '../../res/typo.dart';
import '../../view_model/update_firestore.dart';

class EditSheet extends StatefulWidget {
  final String sheetId;
  const EditSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<EditSheet> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late String newName;
  late String newDetail;

  late File file;
  late PdfDocument doc;

  void _setUp() async {
    file = await PDFApi.loadPDFFromFirebase(widget.sheetId);
    doc = await PdfDocument.openFile(file.path);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUp();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    doc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> sheetData = snapshot.data!.data() as Map<String, dynamic>;

        return StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection("users").doc(sheetData['authorId']).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> authorSnapshot) {
            if (!authorSnapshot.hasData) {
              return Container();
            } else if (authorSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> authorData = authorSnapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: screenWidth * 0.08),
                              height: screenHeight * 0.4,
                              width: screenWidth,
                              child: CachedNetworkImage(
                                imageUrl: sheetData["sheetCoverImage"],
                                color: AppColors.black400,
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Medium16px(
                              text: 'แก้ไขตัวอย่างชีท',
                              color: AppColors.white,
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                            padding: EdgeInsets.only(left: screenHeight * 0.024, top: isPortrait ? screenHeight * 0.03 : screenHeight * 0.08),
                            alignment: Alignment.centerLeft,
                            child: const Medium16px(text: 'ชื่อ')),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: isPortrait ? screenWidth : screenWidth * 0.3,
                            padding: EdgeInsets.all(isPortrait ? screenHeight * 0.002 : screenHeight * 0.004),
                            margin: EdgeInsets.only(
                                left: isPortrait ? screenHeight * 0.024 : screenWidth * 0.2,
                                right: isPortrait ? screenHeight * 0.024 : screenHeight * 0.048),
                            child: MyTextFormField(
                              initialValue: sheetData['sheetName'],
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: RequiredValidator(errorText: 'โปรดใส่ชื่อชีทที่คุณต้องการ'),
                              onSaved: (value) {
                                if (value == '') {
                                  newName = sheetData['sheetName'];
                                } else {
                                  newName = value!;
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                            width: isPortrait ? screenWidth : screenWidth * 0.6,
                            padding: EdgeInsets.only(left: screenHeight * 0.024, top: screenHeight * 0.02),
                            alignment: Alignment.centerLeft,
                            child: const Medium16px(text: 'รายละเอียด')),
                        Container(
                          width: isPortrait ? screenWidth : screenWidth * 0.6,
                          height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.25,
                          padding: EdgeInsets.all(screenHeight * 0.002),
                          margin: EdgeInsets.only(left: screenHeight * 0.024, right: screenHeight * 0.024),
                          child: MyTextFormField(
                            initialValue: sheetData['detailSheet'],
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: RequiredValidator(errorText: 'โปรดใส่คำอธิบายของชีท'),
                            minLine: 6,
                            maxLine: 6,
                            onSaved: (value) {
                              if (value == '') {
                                newDetail = sheetData['detailSheet'];
                              } else {
                                newDetail = value!;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05,
                            top: screenWidth * 0.1,
                            bottom: screenWidth * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlineButton(
                                onPressed: () {
                                  AutoRouter.of(context).pop();
                                },
                                text: 'ยกเลิก',
                              ),
                              PrimaryButton(
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  await EditSheetData().editSheet(context, widget.sheetId, newName, newDetail).then(
                                        (value) => _formKey.currentState!.reset(),
                                      );
                                },
                                text: 'ยืนยัน',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
