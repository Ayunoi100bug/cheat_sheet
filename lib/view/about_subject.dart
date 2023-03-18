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
  List subject = [];
  final subjectTypeOne = [
    CheckBoxState(title: 'วิทยาศาสตร์'),
    CheckBoxState(title: 'คณิตศาสตร์'),
    CheckBoxState(title: 'สังคม'),
    CheckBoxState(title: 'ภาษา'),
    CheckBoxState(title: 'สุขศึกษา'),
    CheckBoxState(title: 'ประวัติศาสตร์'),
    CheckBoxState(title: 'ศิลปะ'),
    CheckBoxState(title: 'ดนตรี'),
    CheckBoxState(title: 'พระพุทธศาสนา'),
  ];
  final subjectTypeTwo = [
    CheckBoxState(title: 'วิทยาศาสตร์'),
    CheckBoxState(title: 'คณิตศาสตร์'),
    CheckBoxState(title: 'ภาษา'),
    CheckBoxState(title: 'ดนตรี'),
    CheckBoxState(title: 'สุขศึกษา'),
    CheckBoxState(title: 'ประวัติศาสตร์'),
    CheckBoxState(title: 'ธุรกิจ'),
    CheckBoxState(title: 'เทคโนโลยี'),
    CheckBoxState(title: 'เกษตรศาสตร์'),
    CheckBoxState(title: 'ศิลปะ'),
    CheckBoxState(title: 'สังคมศาสตร์'),
    CheckBoxState(title: 'กฏหมาย'),
    CheckBoxState(title: 'จิตวิทยา'),
    CheckBoxState(title: 'วิศวกรรมศาตร์'),
    CheckBoxState(title: 'สถาปัตยกรรม'),
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: isPortrait ? screenWidth * 0.08 : screenWidth * 0.04),
                child: Column(
                  children: const [
                    Medium16px(text: "โปรดเลือกวิชาที่สนใจ"),
                  ],
                ),
              ),
              ...subjectTypeOne.map(SingleCheckBox).toList(),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait ? screenWidth * 0.24 : screenWidth * 0.02,
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08,
                    bottom: isPortrait ? 0 : screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      text: 'ข้าม',
                      color: AppColors.tertiary500,
                      onPressed: () {
                        //
                      },
                    ),
                    PrimaryButton(
                      text: 'เสร็จสิ้น',
                      color: AppColors.tertiary500,
                      onPressed: () {
                        UpdateCollection().userRecommented(context, subject);
                        //
                      },
                    ),
                  ],
                ),
              ),
            ],
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: isPortrait ? screenWidth * 0.08 : screenWidth * 0.04),
                child: Column(
                  children: const [
                    Medium16px(text: "โปรดเลือกวิชาที่สนใจ"),
                  ],
                ),
              ),
              ...subjectTypeTwo.map(SingleCheckBox).toList(),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.02,
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08,
                    bottom: isPortrait ? 0 : screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      text: 'ข้าม',
                      color: AppColors.tertiary500,
                      onPressed: () {
                        //
                      },
                    ),
                    PrimaryButton(
                      text: 'เสร็จสิ้น',
                      color: AppColors.tertiary500,
                      onPressed: () {
                        UpdateCollection().userRecommented(context, subject);
                        //
                      },
                    ),
                  ],
                ),
              ),
            ],
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
