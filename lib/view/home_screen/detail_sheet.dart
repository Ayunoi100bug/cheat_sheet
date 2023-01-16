import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/review.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class DetailSheet extends StatefulWidget {
  // final String sheetName;
  // final Array tag;
  // final int star;
  // final Image userAvatar;
  // final String userName;
  // final Image sheetImage;
  // final Array demoSheetImage;
  // final String detail;
  // final Array review;

  const DetailSheet({
    super.key,
    // required this.sheetName,
    // required this.tag,
    // required this.star,
    // required this.userAvatar,
    // required this.userName,
    // required this.sheetImage,
    // required this.detail,
    // required this.review, required this.demoSheetImage
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
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 4),
                        width: isPortrait
                            ? constraints.maxWidth * 0.4
                            : constraints.maxWidth * 0.3,
                        child: const Image(
                          image: NetworkImage(
                              "https://scontent.fbkk22-2.fna.fbcdn.net/v/t1.6435-9/52748949_399475260816189_4259420007764590592_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeHBsm5dx349WFV227XrsFZNeucgEgDpTIF65yASAOlMgWbIDtj649GOlYDE58Ak1f2kPrF8Nvhj1U_LTr6mivDE&_nc_ohc=j3UsfhFV2UsAX96ijpb&_nc_ht=scontent.fbkk22-2.fna&oh=00_AfDhwGCl2AHhuEq605bA57Fg_Vn1rWI6zelRKIj1Tkpv-w&oe=63ECB2EB"),
                        ),
                      ),
                      Container(
                        width: isPortrait
                            ? constraints.maxWidth * 0.6
                            : constraints.maxWidth * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Medium20px(text: "ลิมิต ม.ปลาย"),
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Regular10px(text: "คณิตศาสาตร์"),
                                Regular10px(text: "คณิตพื้นฐาน"),
                                Regular10px(text: "สถิติ"),
                              ],
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.01,
                                ),
                                const Regular12px(text: "5"),
                              ],
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.10,
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
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.favorite_outline,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                const Icon(
                                  UniconsLine.plus_square,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                const Icon(
                                  UniconsLine.cloud_download,
                                  color: AppColors.black600,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.016,
                                ),
                                const Icon(UniconsLine.share),
                              ],
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.10,
                            ),
                            PrimaryButton(
                              text: "อ่านชีท",
                              onPressed: () {
                                AutoRouter.of(context).push(ReadSheetRoute());
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
                padding: const EdgeInsets.only(
                    top: 20, left: 16, right: 16, bottom: 56),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Medium16px(text: "รายละเอียด"),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const Regular12px(
                        text:
                            "เนื้อหาจะประกอบไปด้วย\nการหาค่าเฉลี่ยแบบไม่แจกแจงความถี่\nการหาค่าเฉลี่ยแบบแจกแจงความถี่\nการหาค่าเฉลี่ยแบบถ่วงน้ำหนัก\nการหาค่าเฉลี่ยเลขคณิตรวม\nการหาค่าเฉลี่ยเลขคณิตโดยวิธีทอนค่าข้อมูล")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Medium16px(text: "รีวิว"),
                        InkWell(
                          child: const Regular12px(
                            text: "เขียนรีวิว",
                            underline: true,
                            color: AppColors.primary600,
                          ),
                          onTap: () {
                            print("go to write review");
                          },
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Review(),
                          Review(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    InkWell(
                      child: const Regular12px(
                        text: "ดูทั้งหมด",
                        underline: true,
                        color: AppColors.primary600,
                      ),
                      onTap: () {
                        print("go to review page");
                      },
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
