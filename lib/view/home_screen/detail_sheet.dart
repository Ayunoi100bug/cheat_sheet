import 'dart:ffi';

import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

class DetailSheet extends StatefulWidget {
  // final String sheetName;
  // final Array tag;
  // final int star;
  // final Image userAvatar;
  // final String userName;
  // final Image sheetTitle;
  // final String detail;
  // final Array review;

  const DetailSheet({
    super.key,
    // required this.sheetName,
    // required this.tag,
    // required this.star,
    // required this.userAvatar,
    // required this.userName,
    // required this.sheetTitle,
    // required this.detail,
    // required this.review
  });

  @override
  State<DetailSheet> createState() => _DetailSheetState();
}

class _DetailSheetState extends State<DetailSheet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    children: [
                      Container(
                        color: AppColors.black300,
                        width: constraints.maxWidth * 0.4,
                        //height: double.infinity,
                        child: Medium20px(
                            text:
                                "sheet\nsheet\nsheet\nsheet\nsheet\nsheet\nsheet\nsheet\nsheet"),
                      ),
                      Container(
                        //color: AppColors.error300,
                        width: constraints.maxWidth * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Medium20px(text: "ลิมิต ม.ปลาย"),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Regular10px(text: "คณิตศาสาตร์"),
                                Regular10px(text: "คณิตพื้นฐาน"),
                                Regular10px(text: "สถิติ"),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.01,
                                ),
                                Regular12px(text: "5"),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                  radius: 12,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Regular14px(text: "Macaron"),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite_outline,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                Icon(
                                  UniconsLine.plus_square,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                Icon(
                                  UniconsLine.cloud_download,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                Icon(UniconsLine.share),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            PrimaryButton(
                              text: "อ่านชีท",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                height: screenHeight * 0.25,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Medium16px(text: "รายละเอียด"),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Regular12px(
                        text:
                            "เนื้อหาจะประกอบไปด้วย\nการหาค่าเฉลี่ยแบบไม่แจกแจงความถี่\nการหาค่าเฉลี่ยแบบแจกแจงความถี่\nการหาค่าเฉลี่ยแบบถ่วงน้ำหนัก\nการหาค่าเฉลี่ยเลขคณิตรวม\nการหาค่าเฉลี่ยเลขคณิตโดยวิธีทอนค่าข้อมูล")
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Medium16px(text: "รีวิว"),
                        InkWell(
                          child: Regular12px(
                            text: "เขียนรีวิว",
                            underline: true,
                            color: AppColors.primary600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        //color: AppColors.blue400,

                        ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    InkWell(
                      child: Regular12px(
                        text: "ดูทั้งหมด",
                        underline: true,
                        color: AppColors.primary600,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
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
