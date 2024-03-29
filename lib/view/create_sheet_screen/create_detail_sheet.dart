import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:search_choices/search_choices.dart';

import '../../model/sheet.dart';
import '../../res/components/flushbar.dart';
import '../../res/components/flushbar_icon.dart';

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
  bool isEmpty = false;
  late Future resultLoaded;
  List _tagResult = [];
  List _resultList = [];
  List _dataList = [];
  List _tagList = [];
  List<String> selectedTag = [];
  List<int> selectedIndex = [];
  List<DropdownMenuItem<dynamic>> resultTagAsDropdown = [];

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
        var tagName = tagSnapshot['tagName'].toLowerCase();
        if (tagName.contains(_tagController.text.toLowerCase())) {
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

        resultTagAsDropdown = _resultList.map((item) {
          return DropdownMenuItem<dynamic>(
            value: item['tagName'],
            child: Text(item['tagName'].toString()),
          );
        }).toList();
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
              child: SafeArea(
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
                          validator: (value) {},
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
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                        child: SearchChoices.multiple(
                          fieldDecoration: isEmpty == true ? BoxDecoration(border: Border.all(color: Colors.red)) : null,
                          items: resultTagAsDropdown,
                          selectedItems: selectedIndex,
                          hint: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("ค้นหาแท็ก"),
                          ),
                          searchHint: "แท็กทั้งหมด",
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = value;
                              selectedTag = [];

                              isEmpty = false;

                              for (int i = 0; i < selectedIndex.length; i++) {
                                selectedTag.add(resultTagAsDropdown[selectedIndex[i]].value);
                              }
                            });
                          },
                          closeButton: (selectedItems) {
                            return (selectedItems.isNotEmpty
                                ? "บันทึก ${selectedItems.length == 1 ? '"${resultTagAsDropdown[selectedItems.first].value}"' : '(${selectedItems.length})'}"
                                : "ยกเลิก");
                          },
                          isExpanded: true,
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
                            margin: EdgeInsets.only(left: isPortrait ? screenWidth * 0.048 : screenWidth * 0.24, right: screenWidth * 0.048),
                            width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.125,
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
                                if (_formKey.currentState!.validate() && selectedIndex.isNotEmpty) {
                                  _formKey.currentState!.save();
                                  firebaseStorage.UploadTask? task = await PDFApi.uploadToFirebase(context, pdfFile, sheetId);
                                  task!.whenComplete(() async {
                                    firebaseStorage.UploadTask? coverImage = await PDFApi().createCoverSheetImage(sheetId);
                                    coverImage!.whenComplete(() async {
                                      String coverImage = await PDFApi.getCoverImage(sheetId);
                                      try {
                                        await myCollection
                                            .createSheetCollection(
                                          sheetId,
                                          mySheet.sheetName,
                                          mySheet.detailSheet,
                                          coverImage,
                                          widget.demoPages,
                                          mySheet.sheetTypeFree,
                                          mySheet.price,
                                          mySheet.authorId = userId,
                                          selectedTag,
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
                                } else if (selectedIndex.isEmpty) {
                                  setState(() {
                                    isEmpty = true;
                                  });
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
            ),
          );
        });
  }
}
