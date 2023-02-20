import 'package:auto_route/auto_route.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/components/popup_login.dart';
import 'package:cheat_sheet/res/components/review.dart';
import 'package:cheat_sheet/res/components/tag.dart';
import 'package:cheat_sheet/res/gap_dimension.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/read_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:unicons/unicons.dart';

import '../../data/network/pdf_api.dart';
import '../../model/sheet.dart';
import '../../model/sheet_list.dart';
import '../../res/components/form_field.dart';

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

  @override
  Widget build(BuildContext context) {
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
          List? reviewInSheet = sheetData['review'];
          reviewInSheet ??= []; //ถ้า reviewInSheet เท่ากับ null จะให้เป็น []
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
                                                          child: PageView(
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl: "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                fit: BoxFit.fill,
                                                              ),
                                                              CachedNetworkImage(
                                                                imageUrl: "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                fit: BoxFit.fill,
                                                              ),
                                                              CachedNetworkImage(
                                                                imageUrl: "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                fit: BoxFit.fill,
                                                              ),
                                                              CachedNetworkImage(
                                                                imageUrl: "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                fit: BoxFit.fill,
                                                              ),
                                                              CachedNetworkImage(
                                                                imageUrl: "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ],
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
                                                imageUrl:
                                                    "https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_04.jpg",
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
                                        Medium20px(text: sheetData["sheetName"]),
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
                                              rating: 4,
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
                                            const Regular12px(text: "5"),
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
                                        ),
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
                                                      final file = await PDFApi.loadPDFFromFirebase(sheetData["authorId"], widget.sheetId);
                                                      if (context.mounted) {
                                                        AutoRouter.of(context).push(ReadSheetRoute(sheetId: widget.sheetId, file: file));
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
                                                    final file = await PDFApi.loadPDFFromFirebase(sheetData['authorId'], widget.sheetId);
                                                    if (context.mounted) {
                                                      AutoRouter.of(context).push(ReadSheetRoute(sheetId: widget.sheetId, file: file));
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
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: reviewInSheet!.length > 2 ? 2 : reviewInSheet.length,
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
                                                      userImage: userReviewSnapshot.data!['profileImage'],
                                                      userName: userReviewSnapshot.data!['username'],
                                                      userRating: reviewSnapshot.data!['rating'],
                                                      textReview: reviewSnapshot.data!['text'],
                                                      dateTime: reviewSnapshot.data!['timestamp'],
                                                      like: reviewSnapshot.data!['like']);
                                                }
                                              },
                                            );
                                          }
                                        });
                                  },
                                ),
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
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 24, top: 28, bottom: 28),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Regular16px(
                                          text: 'บันทึกชีทนี้ลง...',
                                        ),
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.tertiary500),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Icon(
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
                                      physics: NeverScrollableScrollPhysics(),
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
                                        return Container(
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return InkWell(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: constraints.maxHeight * 0.8,
                                                      color: AppColors.black300,
                                                    ),
                                                    Container(
                                                      height: constraints.maxHeight * 0.2,
                                                      child: LayoutBuilder(
                                                        builder: (context, constraints) {
                                                          return Container(
                                                            padding: EdgeInsets.only(top: screenWidth * 0.02),
                                                            alignment: Alignment.topCenter,
                                                            height: constraints.maxHeight * 0.5,
                                                            child: Regular16px(text: sheetLists!['sheetListName']),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () async {
                                                  try {
                                                    await _firestoreDb.collection('sheetList').doc(sheetLists!['sheetListId']).update({
                                                      'sid': FieldValue.arrayUnion([sheetId])
                                                    });
                                                    Future.delayed(const Duration(milliseconds: 500), () {
                                                      Navigator.of(context).pop();
                                                      final String message = 'เพิ่มชีทเข้าชีทลิสต์เรียบร้อย!';
                                                      FlushbarPopup.successFlushbar(context, Icon(FontAwesomeIcons.book), message);
                                                    });
                                                  } on FirebaseAuthException catch (e) {
                                                    FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, e.toString());
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
          child: Container(
            height: isPortrait ? screenWidth * 0.52 : screenWidth * 0.29,
            child: Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.040, bottom: isPortrait ? screenWidth * 0.040 : screenWidth * 0.012),
              child: Column(
                children: [
                  Regular16px(
                    text: 'แชร์ชีทไป...',
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          Regular16px(text: 'Facebook'),
                        ],
                      ),
                      onTap: () {
                        print("Facebook");
                      },
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.pink,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          Regular16px(text: 'Instagram'),
                        ],
                      ),
                    ),
                    onTap: () {
                      print("Instagram");
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.020, left: isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                            size: 36,
                          ),
                          SizedBox(
                            width: screenWidth * 0.08,
                          ),
                          Regular16px(text: 'Twitter'),
                        ],
                      ),
                    ),
                    onTap: () {
                      print("Twitter");
                    },
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
