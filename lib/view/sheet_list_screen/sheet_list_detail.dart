import 'package:auto_route/annotations.dart';
import 'package:cheat_sheet/model/sheet_list.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../res/button.dart';
import '../../res/components/flushbar.dart';
import '../../res/components/flushbar_icon.dart';
import '../../res/components/popup_dialog.dart';
import '../../view_model/update_firestore.dart';

class SheetListDetail extends StatefulWidget {
  final String sheetId;
  const SheetListDetail({super.key, @pathParam required this.sheetId});

  @override
  State<SheetListDetail> createState() => _SheetListDetailState();
}

class _SheetListDetailState extends State<SheetListDetail> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("sheetList").doc(widget.sheetId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          List sheetInList = data['sid'];
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.038),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Medium20px(text: data['sheetListName']),
                        ),
                        InkWell(
                          child: Icon(FontAwesomeIcons.ellipsisV, size: screenHeight * 0.024),
                          onTap: () {
                            _BottomSheetList(context, data['sheetListId'], data['sheetListName']);
                          },
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 3 : 5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      mainAxisExtent: isPortrait ? 200 : 250,
                    ),
                    itemCount: sheetInList.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<DocumentSnapshot>(
                        stream: _firestore.collection("sheet").doc(sheetInList[index]).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> sheetSnapshot) {
                          if (!sheetSnapshot.hasData) {
                            return Container();
                          } else if (sheetSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return StreamBuilder<DocumentSnapshot>(
                              stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return Container();
                                } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Sheet(
                                  rating: sheetSnapshot.data?["rating"],
                                  sheetCoverImage: sheetSnapshot.data?["sheetCoverImage"],
                                  authorImage: userSnapshot.data?['profileImage'],
                                  title: sheetSnapshot.data?["sheetName"],
                                  priceSheet: sheetSnapshot.data?["price"],
                                  username: userSnapshot.data?["username"],
                                  sheetId: sheetSnapshot.data?["sid"],
                                );
                              });
                        },
                      );
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

void _BottomSheetList(BuildContext context, String sheetListId, String textSheetListName) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  final _auth = FirebaseAuth.instance;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return SizedBox(
        height: isPortrait ? screenHeight * 0.18 : screenWidth * 0.18,
        child: Column(
          children: [
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(text: 'Edit')),
              onTap: () {
                _BottomEditSheetList(context, sheetListId, textSheetListName);
              },
            ),
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: isPortrait ? screenHeight * 0.08 : screenWidth * 0.08,
                  width: double.infinity,
                  child: const Regular16px(
                    text: 'Delete',
                    color: AppColors.error500,
                  )),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Popup_DeleteSheetList(context, sheetListId),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void _BottomEditSheetList(BuildContext context, String sheetListId, String textSheetListName) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SheetLists _sheetList = SheetLists(sheetListName: '', sheetListId: '', sid: [], authorId: '');
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  final _auth = FirebaseAuth.instance;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom == 0
            ? screenHeight * 0.18
            : (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom) / 1.2,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(isPortrait ? screenHeight * 0.02 : screenWidth * 0.02),
                child: MyTextFormField(
                  initialValue: textSheetListName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    if (value == '') {
                      _sheetList.sheetListName = textSheetListName;
                    } else {
                      _sheetList.sheetListName = value!;
                    }
                  },
                  validator: RequiredValidator(errorText: 'Please enter sheet list name.'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: screenHeight * 0.032),
              alignment: Alignment.centerRight,
              child: PrimaryButton(
                text: 'ส่ง',
                onPressed: () async {
                  _formKey.currentState!.save();
                  try {
                    UpdateSheetListData()
                        .editSheetList(context, sheetListId, _sheetList.sheetListName)
                        .then((value) => _formKey.currentState!.reset());
                  } on FirebaseAuthException catch (e) {
                    FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                  }
                },
                size: 16,
              ),
            ),
          ],
        ),
      );
    },
  );
}
