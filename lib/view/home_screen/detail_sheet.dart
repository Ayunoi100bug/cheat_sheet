import 'package:auto_route/auto_route.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/review.dart';
import 'package:cheat_sheet/res/components/tag.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view/home_screen/create_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:unicons/unicons.dart';

import '../../data/network/pdf_api.dart';

class DetailSheet extends StatefulWidget {
  final int sheetId;
  // final String sheetName;
  // final Array tag;
  // final int star;
  // final Image userAvatar;
  // final String userName;
  // final Image sheetImage;
  // final Array demoSheetImage;
  // final String detail;
  // final double sheetReview;

  const DetailSheet({super.key, @PathParam() required this.sheetId
      // required this.sheetName,
      // required this.tag,
      // required this.star,
      // required this.userAvatar,
      // required this.userName,
      // required this.sheetImage,
      // required this.detail,
      // required this.sheetReview,
      // required this.demoSheetImage
      });

  @override
  State<DetailSheet> createState() => _DetailSheetState();
}

class _DetailSheetState extends State<DetailSheet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: isPortrait ? screenHeight * 0.4 : screenHeight * 0.8,
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
                        child: LayoutBuilder(builder: (context, constraints) {
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    height: screenHeight * 0.6,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenHeight *
                                                                      0.025),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primary500)),
                                                          child: Image.network(
                                                            "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenHeight *
                                                                      0.025),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primary500)),
                                                          child: Image.network(
                                                            "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenHeight *
                                                                      0.025),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primary500)),
                                                          child: Image.network(
                                                            "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenHeight *
                                                                      0.025),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primary500)),
                                                          child: Image.network(
                                                            "https://i.pinimg.com/736x/3b/73/34/3b733419b85fe57cba50ac1921288409.jpg",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                BlinkText(
                                                    'สามารถเลื่อนไปทางขวาได้',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            AppColors.black800),
                                                    beginColor:
                                                        AppColors.black800,
                                                    endColor: AppColors.white,
                                                    times: 20,
                                                    duration:
                                                        Duration(seconds: 1)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Medium20px(text: "ลิมิต ม.ปลาย"),
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
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                  radius: 12,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                const Regular14px(text: "Macaron"),
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
                                Icon(
                                  UniconsLine.plus_square,
                                  color: AppColors.black600,
                                  size: isPortrait ? 32 : 36,
                                ),
                                Icon(
                                  UniconsLine.cloud_download,
                                  color: AppColors.black600,
                                  size: isPortrait ? 32 : 36,
                                ),
                                Icon(
                                  UniconsLine.share,
                                  size: isPortrait ? 32 : 36,
                                ),
                              ],
                            ),
                            PrimaryButton(
                              text: "อ่านชีท",
                              size: 16,
                              onPressed: () async {
                                final url =
                                    'https://www.africau.edu/images/default/sample.pdf';
                                final file = await PDFApi.loadNetwork(url);
                                AutoRouter.of(context).push(ReadSheetRoute(
                                    sheetId: widget.sheetId, file: file));
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
                        padding:
                            EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                        child: Regular12px(
                            text:
                                "เนื้อหาจะประกอบไปด้วย\nการหาค่าเฉลี่ยแบบไม่แจกแจงความถี่\nการหาค่าเฉลี่ยแบบแจกแจงความถี่\nการหาค่าเฉลี่ยแบบถ่วงน้ำหนัก\nการหาค่าเฉลี่ยเลขคณิตรวม\nการหาค่าเฉลี่ยเลขคณิตโดยวิธีทอนค่าข้อมูล"),
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
                                CreateReviewRoute(sheetId: widget.sheetId));
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
                      padding:
                          EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                      child: InkWell(
                        child: const Regular14px(
                          text: "ดูทั้งหมด",
                          underline: true,
                          color: AppColors.primary600,
                        ),
                        onTap: () {
                          AutoRouter.of(context)
                              .push(ReviewSheetRoute(sheetId: widget.sheetId));
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
}
