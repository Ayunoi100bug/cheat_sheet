import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

import '../../model/sheet.dart';
import '../../res/colors.dart';
import '../../res/components/flushbar.dart';
import '../../res/components/flushbar_icon.dart';
import '../../res/components/popup_create_tag.dart';
import '../../res/components/tag.dart';
//import 'package:search_choices/search_choices.dart';

class CreateDetailSheet extends StatefulWidget {
  final List<int> demoPages;
  const CreateDetailSheet({super.key, required this.demoPages});

  @override
  State<CreateDetailSheet> createState() => _CreateDetailSheetState();
}

enum SheetType { free, sell }

class _CreateDetailSheetState extends State<CreateDetailSheet> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _tagController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Sheets mySheet = Sheets(sheetName: '', detailSheet: '', sheetCoverImage: '', demoPages: [], sheetTypeFree: true, price: 0, authorId: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CreateCollection myCollection = CreateCollection();
  SheetType? _sheetType = SheetType.free;
  late Future resultLoaded;
  List _tagResult = [];
  List _resultList = [];
  List _dataList = [];
  List _tagList = [];
  List selectedTag = [];

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = getTagSnapshot();
  }

  _onTagChanged() {
    tagResultsList();
  }

  tagResultsList() {
    var tagResult = [];

    if (_tagController.text != "") {
      for (var tagSnapshot in _tagResult) {
        var tagSubject = tagSnapshot['subject'].toLowerCase();
        if (tagSubject.contains(_tagController.text.toLowerCase())) {
          tagResult.add(tagSnapshot);
        }
      }
    } else {
      tagResult = List.from(_tagResult);
    }
    setState(
      () {
        _resultList = [];
        _dataList = [];
        _tagList = tagResult;

        for (int i = 0; i < _tagList.length; i++) {
          _resultList.add(_tagList[i]);
          _dataList.add(_tagList[i]);
        }
      },
    );
  }

  getTagSnapshot() async {
    var tagData = await _firestore.collection('tag').get();
    setState(
      () {
        _tagResult = tagData.docs.map((doc) => doc.data()).toList();
      },
    );
    tagResultsList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    File? pdfFile = Provider.of<FilePasser>(context).getFile();

    String sheetId = mySheet.sid;
    String userId = FirebaseAuth.instance.currentUser!.uid;

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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
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
                          validator: RequiredValidator(errorText: 'กรุณากรอกชื่อชีทของท่าน.'),
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
                        validator: RequiredValidator(errorText: 'กรุณากรอกรายละเอียดของชีท.'),
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
                    Padding(
                      padding: EdgeInsets.only(left: screenHeight * 0.024),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isPortrait ? 3 : 5,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          mainAxisExtent: isPortrait ? 50 : 250,
                        ),
                        itemCount: selectedTag.length,
                        itemBuilder: (context, index) {
                          return Tag(
                            subject: selectedTag[index],
                            onPressed: () {},
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenHeight * 0.024, right: screenHeight * 0.2),
                      child: TextField(
                        controller: _tagController,
                        cursorColor: AppColors.black900,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          fillColor: AppColors.black200,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
                          hintText: 'เพิ่ม/ค้นหาแท็ก',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
                          hintStyle: const TextStyle(color: AppColors.black400, fontSize: 18),
                          suffixIcon: InkWell(
                            child: Icon(
                              Icons.add,
                              color: AppColors.secondary500,
                            ),
                            onTap: () => print("add tag"),
                          ),
                        ),
                        onChanged: (value) {
                          _onTagChanged();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _resultList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Tag(
                            subject: _resultList[index]['subject'] ?? "",
                            onPressed: () {
                              selectedTag.add(_resultList[index]['subject']);
                              setState(() {});
                              print(selectedTag);
                            },
                          );
                        },
                      ),
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
                              validator: RequiredValidator(errorText: 'กรุณาระบุราคา.'),
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
                              firebaseStorage.UploadTask? task = await PDFApi.uploadToFirebase(context, pdfFile, sheetId);
                              task!.whenComplete(() async {
                                firebaseStorage.UploadTask? coverImage = await PDFApi().createCoverSheetImage(sheetId);
                                coverImage!.whenComplete(() async {
                                  String coverImage = await PDFApi.getCoverImage(sheetId);
                                  try {
                                    myCollection
                                        .createSheetCollection(
                                      sheetId,
                                      mySheet.sheetName,
                                      mySheet.detailSheet,
                                      coverImage,
                                      widget.demoPages,
                                      mySheet.sheetTypeFree,
                                      mySheet.price,
                                      mySheet.authorId = userId,
                                    )
                                        .then(
                                      (value) async {
                                        _formKey.currentState!.reset();

                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          AutoRouter.of(context).popUntilRoot();

                                          final String message = 'อัพโหลดชีทสำเร็จ!';
                                          FlushbarPopup.successFlushbar(context, FlushbarIcon.successIcon, message);
                                        });
                                      },
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                      msg: e.message.toString(),
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                });
                              });
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
        });
  }
}
