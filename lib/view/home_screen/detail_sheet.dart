import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/popup_auth.dart';
import 'package:cheat_sheet/res/components/review.dart';
import 'package:cheat_sheet/res/components/tag.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';

import 'package:cheat_sheet/view_model/file_passer_for_read.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../data/network/pdf_api.dart';
import '../../model/sheet.dart';
import '../../model/sheet_list.dart';
import '../../res/components/form_field.dart';
import '../../res/components/popup_dialog.dart';

class DetailSheet extends StatefulWidget {
  final String sheetId;

  const DetailSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<DetailSheet> createState() => _DetailSheetState();
}

class _DetailSheetState extends State<DetailSheet> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  UpdateCollection updateFS = UpdateCollection();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    String ratingSheet;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> sheetData = snapshot.data!.data() as Map<String, dynamic>;
          List? reviewInSheet = sheetData['review'];
          reviewInSheet ??= []; //ถ้า reviewInSheet เท่ากับ null จะให้เป็น []
          if (sheetData['rating'].toString().contains('.') && !sheetData['rating'].toString().endsWith('.0')) {
            ratingSheet = sheetData['rating'].toStringAsFixed(1);
          } else {
            ratingSheet = sheetData['rating'].toString().replaceAll(RegExp(r'.0+$'), "");
          }
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
                      child: Column(
                        children: [
                          Container(
                            height: isPortrait ? screenHeight * 0.4 : screenHeight * 0.8,
                            padding: EdgeInsets.only(top: screenHeight * 0.016, left: screenHeight * 0.016, right: screenHeight * 0.016),
                            child: LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: isPortrait ? constraints.maxWidth * 0.5 : constraints.maxWidth * 0.4,
                                    height: constraints.maxHeight * 0.9,
                                    child: LayoutBuilder(builder: (context, constraints) {
                                      return InkWell(
                                          onTap: (() {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          height: screenHeight * 0.55,
                                                          width: screenWidth,
                                                          child: PageView.builder(
                                                            itemCount: sheetData['demoPages'].length,
                                                            itemBuilder: (context, index) {
                                                              return PdfPageView(
                                                                pdfDocument: doc,
                                                                pageNumber: sheetData['demoPages'][index],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: screenWidth * 0.04,
                                                        ),
                                                        const BlinkText('สามารถเลื่อนไปทางขวาได้',
                                                            style: TextStyle(fontSize: 20, color: AppColors.black800),
                                                            beginColor: AppColors.black800,
                                                            endColor: AppColors.white,
                                                            times: 20,
                                                            duration: Duration(seconds: 1)),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: sheetData["sheetCoverImage"],
                                                color: AppColors.black400,
                                                colorBlendMode: BlendMode.modulate,
                                                fit: BoxFit.cover,
                                                height: constraints.maxHeight,
                                              ),
                                              const Medium16px(
                                                text: 'ดูตัวอย่างชีทที่นี่',
                                                color: AppColors.white,
                                              ),
                                            ],
                                          ));
                                    }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.03,
                                      vertical: constraints.maxHeight * 0.05,
                                    ),
                                    width: isPortrait ? constraints.maxWidth * 0.5 : constraints.maxWidth * 0.6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Medium20px(
                                          text: sheetData["sheetName"],
                                          activateOverflow: true,
                                          maxLine: 2,
                                        ),
                                        SingleChildScrollView(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: const [
                                              Tag(
                                                subject: "คณิตศาสาตร์",
                                              ),
                                              Tag(
                                                subject: "คณิตพื้นฐาน",
                                              ),
                                              Tag(
                                                subject: "สถิติ",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: sheetData['rating'],
                                              itemBuilder: (context, index) => const Icon(
                                                Icons.star,
                                                color: AppColors.warning400,
                                              ),
                                              itemCount: 5,
                                              itemSize: screenWidth * 0.04,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),
                                            Regular12px(text: ratingSheet),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: CachedNetworkImageProvider(authorData['profileImage']),
                                              radius: 12,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.02,
                                            ),
                                            Regular14px(text: authorData['username']),
                                          ],
                                        ),
                                        if (sheetData['authorId'] == _auth.currentUser!.uid) ...[
                                          Wrap(
                                            spacing: 10,
                                            children: [
                                              InkWell(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors.black500,
                                                  size: isPortrait ? 32 : 36,
                                                ),
                                                onTap: () {
                                                  AutoRouter.of(context).push(EditSheetRoute());
                                                },
                                              ),
                                              InkWell(
                                                child: Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: AppColors.error500,
                                                  size: isPortrait ? 32 : 36,
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => Popup_DeleteSheet(context, widget.sheetId),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ] else ...[
                                          Wrap(
                                            spacing: 10,
                                            children: [
                                              Icon(
                                                Icons.favorite_outline,
                                                color: AppColors.black600,
                                                size: isPortrait ? 32 : 36,
                                              ),
                                              InkWell(
                                                child: Icon(
                                                  Icons.playlist_add_rounded,
                                                  color: AppColors.black600,
                                                  size: isPortrait ? 32 : 36,
                                                ),
                                                onTap: () {
                                                  _BottomSheetList(context, widget.sheetId);
                                                },
                                              ),
                                              Icon(
                                                UniconsLine.arrow_circle_down,
                                                color: AppColors.black600,
                                                size: isPortrait ? 32 : 36,
                                              ),
                                              InkWell(
                                                child: Icon(
                                                  UniconsLine.share,
                                                  size: isPortrait ? 32 : 36,
                                                ),
                                                onTap: () {
                                                  _shareSheet(context);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                        StreamBuilder<DocumentSnapshot>(
                                            stream: _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> currentUserSnapshot) {
                                              if (!currentUserSnapshot.hasData) {
                                                return Container();
                                              } else if (_auth.currentUser == null) {
                                                return PrimaryButton(
                                                  coinIcon: sheetData['price'] == 0 ? false : true,
                                                  text: sheetData['price'] == 0 ? "อ่านชีท" : sheetData['price'].toString(),
                                                  size: 16,
                                                  onPressed: () async {
                                                    if (sheetData['price'] == 0) {
                                                      if (context.mounted) {
                                                        Provider.of<FilePasserForRead>(context, listen: false).setFile(file);
                                                        AutoRouter.of(context).push(ReadSheetRoute(sheetId: widget.sheetId));
                                                      }
                                                    }
                                                    if (context.mounted) {
                                                      await updateFS.userBuySheet(context, sheetData['sid'], authorData['uid'], sheetData['price']);
                                                    }
                                                  },
                                                );
                                              } else if (currentUserSnapshot.connectionState == ConnectionState.waiting) {
                                                return PrimaryButton(
                                                  text: "...",
                                                  size: 16,
                                                  onPressed: () {},
                                                );
                                              }
                                              Map<String, dynamic> currentUserData = currentUserSnapshot.data!.data() as Map<String, dynamic>;
                                              return PrimaryButton(
                                                coinIcon: sheetData['price'] == 0 ||
                                                        currentUserData['buyedSheet'].contains(sheetData['sid']) ||
                                                        currentUserData['uid'] == sheetData['authorId']
                                                    ? false
                                                    : true,
                                                text: sheetData['price'] == 0 ||
                                                        currentUserData['buyedSheet'].contains(sheetData['sid']) ||
                                                        currentUserData['uid'] == sheetData['authorId']
                                                    ? "อ่านชีท"
                                                    : sheetData['price'].toString(),
                                                size: 16,
                                                onPressed: () async {
                                                  if (sheetData['price'] == 0 ||
                                                      currentUserData['buyedSheet'].contains(sheetData['sid']) ||
                                                      currentUserData['uid'] == sheetData['authorId']) {
                                                    if (context.mounted) {
                                                      Provider.of<FilePasserForRead>(context, listen: false).setFile(file);
                                                      AutoRouter.of(context).push(ReadSheetRoute(sheetId: widget.sheetId));
                                                    }
                                                  }
                                                  if (context.mounted) {
                                                    await updateFS.userBuySheet(context, sheetData['sid'], authorData['uid'], sheetData['price']);
                                                  }
                                                },
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.04),
                            width: screenWidth,
                            child: LayoutBuilder(builder: (context, constraints) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Medium16px(text: "รายละเอียด"),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                                    child: Regular12px(text: sheetData["detailSheet"]),
                                  )
                                ],
                              );
                            }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Medium16px(text: "รีวิว"),
                                    InkWell(
                                      child: const Regular14px(
                                        text: "เขียนรีวิว",
                                        underline: true,
                                        color: AppColors.primary600,
                                      ),
                                      onTap: () {
                                        AutoRouter.of(context).push(CreateReviewRoute(sheetId: widget.sheetId));
                                      },
                                    ),
                                  ],
                                ),
                                if (reviewInSheet!.isEmpty) ...[
                                  SizedBox(
                                    height: screenWidth * 0.57,
                                    child: const Center(
                                      child: Regular16px(text: "ยังไม่มีรีวิว"),
                                    ),
                                  ),
                                ],
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: reviewInSheet.length > 2 ? 2 : reviewInSheet.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: _firestore.collection("review").doc(reviewInSheet![index]).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> reviewSnapshot) {
                                          if (!reviewSnapshot.hasData) {
                                            return Container();
                                          } else if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else {
                                            return StreamBuilder<DocumentSnapshot>(
                                              stream: _firestore.collection("users").doc(reviewSnapshot.data!['reviewerId']).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userReviewSnapshot) {
                                                if (!userReviewSnapshot.hasData) {
                                                  return Container();
                                                } else if (userReviewSnapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                } else {
                                                  return Review(
                                                      sheetId: sheetData['sid'],
                                                      userId: userReviewSnapshot.data!['uid'],
                                                      userImage: userReviewSnapshot.data!['profileImage'],
                                                      userName: userReviewSnapshot.data!['username'],
                                                      userRating: reviewSnapshot.data!['rating'],
                                                      textReview: reviewSnapshot.data!['text'],
                                                      reviewId: reviewSnapshot.data!['rid'],
                                                      dateTime: reviewSnapshot.data!['timestamp'],
                                                      like: reviewSnapshot.data!['like']);
                                                }
                                              },
                                            );
                                          }
                                        });
                                  },
                                ),
                                if (reviewInSheet.isNotEmpty) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                                    child: InkWell(
                                      child: const Regular14px(
                                        text: "ดูทั้งหมด",
                                        underline: true,
                                        color: AppColors.primary600,
                                      ),
                                      onTap: () {
                                        AutoRouter.of(context).push(ReviewSheetRoute(sheetId: widget.sheetId));
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  void _BottomSheet(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
    final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final SheetLists _sheetLists = SheetLists(sheetListName: '', sid: [], authorId: '', sheetListId: '');
    final Future<FirebaseApp> firebase = Firebase.initializeApp();
    CreateCollection myCollection = CreateCollection();

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
                height: screenHeight * 0.025,
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
                    validator: RequiredValidator(errorText: 'โปรดใส่ชื่อชีทลิสต์ของคุณ'),
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
                        .createSheetListAndUpdateCollection(
                      context,
                      _sheetLists.sheetListName,
                      _sheetLists.sid = [],
                      _sheetLists.authorId = _auth.currentUser!.uid,
                      _sheetLists.sheetListId = uuid.v4(),
                      _sheetLists.sheetListCoverImage = '',
                      widget.sheetId,
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

  void _BottomSheetList(context, sheetId) {
    final _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
    double screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        )),
        builder: (BuildContext context) {
          return StreamBuilder(
              stream: _auth.authStateChanges(),
              builder: (context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasData) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: _firestoreDb.collection("sheetList").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final mySheetLists = snapshot.data?.docs.where((document) => document["authorId"] == _auth.currentUser?.uid);
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 24, top: 28, bottom: 28),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Regular16px(
                                        text: 'บันทึกชีทนี้ลง...',
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.tertiary500),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: const Icon(
                                            FontAwesomeIcons.plus,
                                            color: AppColors.tertiary500,
                                            size: 24,
                                          ),
                                        ),
                                        onTap: () {
                                          _BottomSheet(context);
                                        },
                                      )
                                    ],
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
                                      return LayoutBuilder(
                                        builder: (context, constraints) {
                                          return InkWell(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: constraints.maxHeight * 0.8,
                                                  color: sheetLists!['sheetListCoverImage'] == '' ? AppColors.black300 : Colors.transparent,
                                                  child: Stack(
                                                    children: [
                                                      sheetLists['sid'].contains(widget.sheetId)
                                                          ? Opacity(
                                                              opacity: 0.5,
                                                              child: CachedNetworkImage(
                                                                imageUrl: sheetLists["sheetListCoverImage"],
                                                              ),
                                                            )
                                                          : Container(
                                                              child: sheetLists['sheetListCoverImage'] != ''
                                                                  ? CachedNetworkImage(
                                                                      imageUrl: sheetLists["sheetListCoverImage"],
                                                                    )
                                                                  : Container(),
                                                            ),
                                                      Center(
                                                        child: sheetLists['sid'].contains(widget.sheetId)
                                                            ? InkWell(
                                                                child: const Icon(
                                                                  FontAwesomeIcons.check,
                                                                  color: AppColors.tertiary600,
                                                                ),
                                                                onTap: () {
                                                                  UpdateSheetListData()
                                                                      .removeSheetFromList(context, sheetLists['sheetListId'], widget.sheetId);
                                                                },
                                                              )
                                                            : Container(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
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
                                              ],
                                            ),
                                            onTap: () async {
                                              try {
                                                UpdateSheetListData().updateSheetList(context, sheetLists['sheetListId'], widget.sheetId);
                                              } on FirebaseAuthException catch (e) {
                                                FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                                              }
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                } else {
                  return Popup_Login(context);
                }
              });
        });
  }

  void _shareSheet(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      )),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: isPortrait ? screenWidth * 0.52 : screenWidth * 0.29,
            child: Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.040, bottom: isPortrait ? screenWidth * 0.040 : screenWidth * 0.012),
              child: Column(
                children: [
                  const Regular16px(
                    text: 'แชร์ชีทไป...',
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          const Regular16px(text: 'Facebook'),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.pink,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          const Regular16px(text: 'Instagram'),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          const Regular16px(text: 'Twitter'),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
