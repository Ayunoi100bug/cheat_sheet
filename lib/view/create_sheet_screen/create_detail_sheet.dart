import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

import '../../model/sheet.dart';
import '../../res/components/flushbar.dart';
import '../../res/components/flushbar_icon.dart';

class CreateDetailSheet extends StatefulWidget {
  const CreateDetailSheet({super.key});

  @override
  State<CreateDetailSheet> createState() => _CreateDetailSheetState();
}

enum SheetType { free, sell }

class _CreateDetailSheetState extends State<CreateDetailSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, price: 0, authorId: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CreateCollection myCollection = CreateCollection();
  SheetType? _sheetType = SheetType.free;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    File? pdfFile = Provider.of<FilePasser>(context).getFile();

    String sheetId = mySheet.sid;

    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                    child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(isPortrait ? screenHeight * 0.024 : screenHeight * 0.048),
                        height: isPortrait ? screenHeight * 0.35 : screenHeight * 0.6,
                        child: PDFView(
                          filePath: pdfFile?.path,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                          padding: EdgeInsets.only(left: screenHeight * 0.024, top: isPortrait ? screenHeight * 0.04 : screenHeight * 0.08),
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: RequiredValidator(errorText: 'Please enter sheet name.'),
                            onSaved: (value) {
                              mySheet.sheetName = value!;
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: RequiredValidator(errorText: 'Please enter detail.'),
                          minLine: 6,
                          maxLine: 6,
                          onSaved: (value) {
                            mySheet.detailSheet = value!;
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                          padding: EdgeInsets.only(left: screenHeight * 0.024, top: isPortrait ? screenHeight * 0.02 : screenHeight * 0.04),
                          alignment: Alignment.centerLeft,
                          child: const Medium16px(text: 'แท็ก')),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: isPortrait ? screenHeight * 0.024 : screenWidth * 0.2, top: screenHeight * 0.01),
                              width: isPortrait ? screenWidth * 0.2 : screenWidth * 0.1,
                              height: isPortrait ? screenHeight * 0.05 : screenHeight * 0.1,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(30),
                                child: const Align(alignment: Alignment.center, child: Icon(FontAwesomeIcons.plus)),
                                dashPattern: [10, 10],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                          padding: EdgeInsets.only(left: screenHeight * 0.024, top: screenHeight * 0.02),
                          alignment: Alignment.centerLeft,
                          child: const Medium16px(text: 'ประเภทของชีท')),
                      Container(
                        margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Medium16px(text: 'ฟรี'),
                              leading: Radio<SheetType>(
                                value: SheetType.free,
                                groupValue: _sheetType,
                                onChanged: (SheetType? value) {
                                  setState(() {
                                    _sheetType = value;
                                    mySheet.sheetTypeFree = true;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Medium16px(text: 'ขาย'),
                              leading: Radio<SheetType>(
                                value: SheetType.sell,
                                groupValue: _sheetType,
                                onChanged: (SheetType? value) {
                                  setState(() {
                                    _sheetType = value;
                                    mySheet.sheetTypeFree = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_sheetType == SheetType.sell)
                        Container(
                            margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2),
                            padding: EdgeInsets.only(left: screenHeight * 0.024, bottom: screenHeight * 0.01),
                            alignment: Alignment.centerLeft,
                            child: const Medium16px(text: 'ราคา')),
                      if (_sheetType == SheetType.sell)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(screenHeight * 0.002),
                            margin: EdgeInsets.only(left: isPortrait ? screenHeight * 0.024 : screenWidth * 0.2, right: screenHeight * 0.024),
                            width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.125,
                            height: isPortrait ? screenHeight * 0.04 : screenHeight * 0.08,
                            child: MyTextFormField(
                                hintText: 'หน่วย coin',
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: RequiredValidator(errorText: 'Please enter price.'),
                                onSaved: (value) {
                                  mySheet.price = int.parse(value!);
                                }),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: isPortrait ? 0 : screenWidth * 0.2, top: isPortrait ? 0 : screenHeight * 0.04),
                            padding: EdgeInsets.all(screenHeight * 0.024),
                            child: OutlineButton(
                              text: 'ยกเลิก',
                              onPressed: () {
                                AutoRouter.of(context).popUntilRoot();
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: isPortrait ? 0 : screenWidth * 0.2, top: isPortrait ? 0 : screenHeight * 0.04),
                            padding: EdgeInsets.all(screenHeight * 0.024),
                            child: PrimaryButton(
                              text: 'เสร็จสิ้น',
                              onPressed: () async {
                                _formKey.currentState!.save();
                                try {
                                  myCollection
                                      .createSheetCollection(
                                    sheetId,
                                    mySheet.sheetName,
                                    mySheet.detailSheet,
                                    mySheet.sheetTypeFree,
                                    mySheet.price,
                                    mySheet.authorId = FirebaseAuth.instance.currentUser!.uid,
                                  )
                                      .then(
                                    (value) async {
                                      _formKey.currentState!.reset();
                                      // debugPrint("Register Success");
                                      firebaseStorage.UploadTask? task =
                                          await PDFApi.uploadToFirebase(context, pdfFile, FirebaseAuth.instance.currentUser!.uid, sheetId);
                                      Future.delayed(const Duration(milliseconds: 500), () {
                                        AutoRouter.of(context).popUntilRoot();

                                        final String message = 'อัพโหลดชีทสำเร็จ!';
                                        FlushbarPopup.successFlushbar(context, FlushbarIcon.errorIcon, message);
                                      });
                                    },
                                  );
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                    msg: e.message.toString(),
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
