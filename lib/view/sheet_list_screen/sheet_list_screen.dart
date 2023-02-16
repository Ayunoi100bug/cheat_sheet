import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cheat_sheet/model/sheet_list.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/components/popup_login.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uuid/uuid.dart';
import '../../res/gap_dimension.dart';

const uuid = Uuid();

class SheetListScreen extends StatefulWidget {
  const SheetListScreen({super.key});

  @override
  State<SheetListScreen> createState() => _SheetListScreenState();
}

class _SheetListScreenState extends State<SheetListScreen> with AutomaticKeepAliveClientMixin {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Users users = Users(username: '', password: '', email: '', uid: '', profileImage: '');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return Popup_Login(context);
          } else {
            return StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("sheetList").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final mySheetLists = snapshot.data?.docs.where((document) => document["authorId"] == _auth.currentUser?.uid);
                    return Scaffold(
                      resizeToAvoidBottomInset: true,
                      body: SafeArea(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: screenWidth * 0.032, right: screenWidth * 0.032),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.tertiary500),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: const Icon(
                                            FontAwesomeIcons.plus,
                                            color: AppColors.tertiary500,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      _BottomSheet(context);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: screenWidth < 480
                                          ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.1)
                                          : MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 0.4),
                                    ),
                                    itemCount: mySheetLists?.length,
                                    itemBuilder: (context, index) {
                                      var sheetLists = mySheetLists?.elementAt(index);
                                      var mySheet = sheetLists!['sid'];
                                      return InkWell(
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Column(
                                              children: [
                                                Container(
                                                  height: constraints.maxHeight * 0.8,
                                                  color: AppColors.black300,
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    height: constraints.maxHeight * 0.2,
                                                    child: LayoutBuilder(
                                                      builder: (context, constraints) {
                                                        return Container(
                                                          padding: EdgeInsets.only(top: screenWidth * 0.02),
                                                          alignment: Alignment.topCenter,
                                                          height: constraints.maxHeight * 0.5,
                                                          child: Regular16px(text: sheetLists['sheetListName']),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        onTap: () {
                                          AutoRouter.of(context).push(
                                            SheetListDetailRoute(sheetId: sheetLists['sheetListId']),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  }
                });
          }
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void _BottomSheet(context) {
  double screenHeight = MediaQuery.of(context).size.height;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SheetLists _sheetLists = SheetLists(sheetListName: '', sid: [], authorId: '', sheetListId: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CreateCollection myCollection = CreateCollection();
  final _auth = FirebaseAuth.instance;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).viewInsets.bottom == 0
            ? screenHeight * 0.3
            : MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            const Regular16px(
              text: 'ชีทลิสต์ใหม่',
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Form(
              key: _formKey,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyTextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'ชื่อชีทลิสต์',
                  onSaved: (value) {
                    _sheetLists.sheetListName = value!;
                  },
                  validator: RequiredValidator(errorText: 'Please enter sheet list name.'),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            PrimaryButton(
              text: 'บันทึก',
              onPressed: () async {
                _formKey.currentState!.save();
                try {
                  myCollection
                      .createSheetListCollection(
                    _sheetLists.sheetListName,
                    _sheetLists.sid = [],
                    _sheetLists.authorId = _auth.currentUser!.uid,
                    _sheetLists.sheetListId = uuid.v4(),
                  )
                      .then(
                    (value) {
                      _formKey.currentState!.reset();
                      AutoRouter.of(context).popUntilRoot();
                    },
                  );
                  await _firestoreDb.collection('users').doc(_auth.currentUser!.uid).update({
                    'sheetLists': FieldValue.arrayUnion([_sheetLists.sheetListId])
                  });
                } on FirebaseAuthException catch (e) {
                  FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                }
              },
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
        ),
      );
    },
  );
}
