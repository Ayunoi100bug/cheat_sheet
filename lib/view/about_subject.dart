import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../res/button.dart';
import '../res/components/custom_appbar.dart';
import '../res/components/tag.dart';

class AboutSubject extends StatefulWidget {
  final String grade;
  const AboutSubject({super.key, required this.grade});

  @override
  State<AboutSubject> createState() => _AboutSubjectState();
}

class _AboutSubjectState extends State<AboutSubject> {
  late bool isChecked = false;
  List subject = [];
  final subjectTypeOne = [
    'วิทยาศาสตร์',
    'สังคม',
    'ภาษา',
    'คณิตศาสตร์',
    'ศิลปะ',
    'ดนตรี',
    'ประวัติศาสตร์',
    'สุขศึกษา',
    'พละ',
    'พระพุทธศาสนา',
  ];
  final subjectTypeTwo = [
    'วิทยาศาสตร์',
    'คณิตศาสตร์',
    'ภาษา',
    'ดนตรี',
    'สุขศึกษา',
    'ประวัติศาสตร์',
    'ธุรกิจ',
    'เทคโนโลยี',
    'เกษตรศาสตร์',
    'ศิลปะ',
    'สังคมศาสตร์',
    'กฏหมาย',
    'จิตวิทยา',
    'วิศวกรรมศาตร์',
    'สถาปัตยกรรม',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (widget.grade != 'มหาวิทยาลัย') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomAppBar.appBarColor,
          title: CustomAppBar.textLogo,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isPortrait ? screenWidth * 0.08 : screenWidth * 0.02),
                  child: Medium16px(text: "โปรดเลือกวิชาที่สนใจ"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 2 : 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: isPortrait ? 5 : 0,
                      mainAxisExtent: isPortrait ? 36 : 40,
                    ),
                    itemCount: subjectTypeOne.length,
                    itemBuilder: (context, index) {
                      return SelectTag(
                        isChecked: true,
                        subject: subjectTypeOne[index].toString(),
                        onPressed: () {
                          if (subject.contains(subjectTypeOne[index])) {
                            subject.remove(subjectTypeOne[index]);
                          } else {
                            subject.add(subjectTypeOne[index]);
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isPortrait ? screenWidth * 0.96 : screenWidth * 0.02,
                      left: isPortrait ? screenWidth * 0.08 : screenWidth * 0.1,
                      right: isPortrait ? screenWidth * 0.08 : screenWidth * 0.2,
                      bottom: isPortrait ? 0 : screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        text: 'ข้าม',
                        color: AppColors.tertiary500,
                        onPressed: () {
                          //ให้อาททำ
                        },
                      ),
                      PrimaryButton(
                        text: 'เสร็จสิ้น',
                        color: AppColors.tertiary500,
                        onPressed: () {
                          UpdateCollection().userRecommented(context, subject);
                          //ให้อาททำ
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomAppBar.appBarColor,
          title: CustomAppBar.textLogo,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isPortrait ? screenWidth * 0.08 : screenWidth * 0.02),
                  child: Medium16px(text: "โปรดเลือกวิชาที่สนใจ"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 2 : 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: isPortrait ? 5 : 0,
                      mainAxisExtent: isPortrait ? 36 : 40,
                    ),
                    itemCount: subjectTypeTwo.length,
                    itemBuilder: (context, index) {
                      return SelectTag(
                        subject: subjectTypeTwo[index].toString(),
                        onPressed: () {
                          if (subject.contains(subjectTypeTwo[index])) {
                            subject.remove(subjectTypeTwo[index]);
                          } else {
                            subject.add(subjectTypeTwo[index]);
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isPortrait ? screenWidth * 0.68 : screenWidth * 0.02,
                      left: isPortrait ? screenWidth * 0.08 : screenWidth * 0.1,
                      right: isPortrait ? screenWidth * 0.08 : screenWidth * 0.12,
                      bottom: isPortrait ? 0 : screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        text: 'ข้าม',
                        color: AppColors.tertiary500,
                        onPressed: () {
                          //ให้อาทททำ
                        },
                      ),
                      PrimaryButton(
                        text: 'เสร็จสิ้น',
                        color: AppColors.tertiary500,
                        onPressed: () {
                          UpdateCollection().userRecommented(context, subject);
                          //ให้อาทททำ
                        },
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

  Widget SingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
      activeColor: AppColors.secondary500,
      value: checkbox.value,
      title: Medium16px(text: checkbox.title),
      onChanged: (value) {
        setState(() => checkbox.value = value!);
        if (checkbox.value == true) {
          subject.add(checkbox.title);
        } else {
          subject.remove(checkbox.title);
        }
      });
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
