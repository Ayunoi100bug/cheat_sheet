import 'package:auto_route/auto_route.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/review.dart';
import 'package:cheat_sheet/res/components/tag.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../data/network/pdf_api.dart';
import '../../res/components/form_field.dart';

class DetailSheet extends StatefulWidget {
  final String sheetId;

  const DetailSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<DetailSheet> createState() => _DetailSheetState();
}

class _DetailSheetState extends State<DetailSheet> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            var sheet = snapshot.data?["sid"];
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: isPortrait
                            ? screenHeight * 0.4
                            : screenHeight * 0.8,
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.016,
                            left: screenHeight * 0.016,
                            right: screenHeight * 0.016),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Row(
                            children: [
                              SizedBox(
                                width: isPortrait
                                    ? constraints.maxWidth * 0.5
                                    : constraints.maxWidth * 0.4,
                                height: constraints.maxHeight * 0.9,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return InkWell(
                                      onTap: (() {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  content: Stack(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: screenHeight * 0.7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Container(
                                                            height:
                                                                screenHeight *
                                                                    0.6,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: screenHeight *
                                                                          0.025),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primary500)),
                                                                  child: Image
                                                                      .network(
                                                                    "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: screenHeight *
                                                                          0.025),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primary500)),
                                                                  child: Image
                                                                      .network(
                                                                    "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: screenHeight *
                                                                          0.025),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primary500)),
                                                                  child: Image
                                                                      .network(
                                                                    "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: screenHeight *
                                                                          0.025),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primary500)),
                                                                  child: Image
                                                                      .network(
                                                                    "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container()),
                                                        BlinkText(
                                                            'สามารถเลื่อนไปทางขวาได้',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: AppColors
                                                                    .black800),
                                                            beginColor:
                                                                AppColors
                                                                    .black800,
                                                            endColor:
                                                                AppColors.white,
                                                            times: 20,
                                                            duration: Duration(
                                                                seconds: 1)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            });
                                      }),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(
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
                                width: isPortrait
                                    ? constraints.maxWidth * 0.5
                                    : constraints.maxWidth * 0.6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Medium20px(text: data["sheetName"]),
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
                                          itemBuilder: (context, index) => Icon(
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
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: _firestore
                                          .collection("users")
                                          .doc(data["uid"])
                                          .snapshots(),
                                      builder: (context, userSnapshot) {
                                        if (!userSnapshot.hasData ||
                                            userSnapshot.data!.data() == null) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        userSnapshot.data?[
                                                            "profileImage"]),
                                                radius: 12,
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              Regular14px(
                                                  text: userSnapshot
                                                      .data?["username"]),
                                            ],
                                          );
                                        }
                                      },
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
                                            UniconsLine.plus_square,
                                            color: AppColors.black600,
                                            size: isPortrait ? 32 : 36,
                                          ),
                                          onTap: () {
                                            _BottomSheetList(context);
                                          },
                                        ),
                                        Icon(
                                          UniconsLine.cloud_download,
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
                                    PrimaryButton(
                                      text: "อ่านชีท",
                                      size: 16,
                                      onPressed: () async {
                                        final url =
                                            'https://www.africau.edu/images/default/sample.pdf';
                                        final file =
                                            await PDFApi.loadNetwork(url);
                                        AutoRouter.of(context).push(
                                            ReadSheetRoute(
                                                sheetId: widget.sheetId,
                                                file: file));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenWidth * 0.04),
                        width: screenWidth,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Medium16px(text: "รายละเอียด"),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.01),
                                child: Regular12px(text: data["detailSheet"]),
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
                                    AutoRouter.of(context).push(
                                        CreateReviewRoute(
                                            sheetId: widget.sheetId));
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Review(userRating: 4),
                                Review(userRating: 2.5),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.04),
                              child: InkWell(
                                child: const Regular14px(
                                  text: "ดูทั้งหมด",
                                  underline: true,
                                  color: AppColors.primary600,
                                ),
                                onTap: () {
                                  AutoRouter.of(context).push(ReviewSheetRoute(
                                      sheetId: widget.sheetId));
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
          }
        });
  }
}

void _BottomSheetList(context) {
  double screenWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 24, top: 28, bottom: 28),
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
                        FontAwesomeIcons.add,
                        color: AppColors.tertiary500,
                        size: 24,
                      ),
                    ),
                    onTap: () {
                      print("add list");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
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
            padding: EdgeInsets.only(
                top: screenWidth * 0.040,
                bottom: isPortrait ? screenWidth * 0.040 : screenWidth * 0.012),
            child: Column(
              children: [
                Regular16px(
                  text: 'แชร์ชีทไป...',
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top:
                          isPortrait ? screenWidth * 0.04 : screenWidth * 0.020,
                      left:
                          isPortrait ? screenWidth * 0.32 : screenWidth * 0.4),
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
                        top: isPortrait
                            ? screenWidth * 0.04
                            : screenWidth * 0.020,
                        left: isPortrait
                            ? screenWidth * 0.32
                            : screenWidth * 0.4),
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
                        top: isPortrait
                            ? screenWidth * 0.04
                            : screenWidth * 0.020,
                        left: isPortrait
                            ? screenWidth * 0.32
                            : screenWidth * 0.4),
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
