import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/model/sheet_list.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/res/components/popup_auth.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  Users users = Users(username: '', password: '', email: '', uid: '', profileImage: '', subject: []);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return Popup_Login(context);
          }
          return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("sheetList").orderBy("timestamp", descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final mySheetLists = snapshot.data?.docs.where((document) => document["authorId"] == _auth.currentUser?.uid);
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  floatingActionButton: FloatingActionButton(
                    splashColor: AppColors.tertiary600,
                    backgroundColor: AppColors.tertiary700.withOpacity(0.7),
                    elevation: 0,
                    onPressed: () {
                      _BottomSheet(context);
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                  body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isPortrait ? 3 : 5,
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
                                              color: sheetLists['sheetListCoverImage'] == '' ? AppColors.black300 : Colors.transparent,
                                              child: sheetLists['sheetListCoverImage'] != ''
                                                  ? CachedNetworkImage(
                                                      imageUrl: sheetLists["sheetListCoverImage"],
                                                    )
                                                  : Container(),
                                            ),
                                            InkWell(
                                              child: SizedBox(
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
              });
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void _BottomSheet(context) {
  double screenHeight = MediaQuery.of(context).size.height;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '', subject: []);
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
      return SizedBox(
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
                child: MyTextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'ชื่อชีทลิสต์',
                  onSaved: (value) {
                    _sheetLists.sheetListName = value!;
                  },
                  validator: RequiredValidator(errorText: 'กรุณากรอกชื่อชีทลิสต์ของท่าน.'),
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
                if (_formKey.currentState!.validate()) {
                  try {
                    await myCollection
                        .createSheetListCollection(
                      context,
                      _sheetLists.sheetListName,
                      _sheetLists.sid = [],
                      _sheetLists.authorId = _auth.currentUser!.uid,
                      _sheetLists.sheetListId = uuid.v4(),
                      _sheetLists.sheetListCoverImage = '',
                    )
                        .then(
                      (value) async {
                        _formKey.currentState!.reset();
                        await UpdateCollection().achievement(context, 'trackingCreateSheetList');
                      },
                    );
                  } on FirebaseAuthException catch (e) {
                    FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                  }
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
