import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/components/custom_appbar.dart';
import '../../res/typo.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  final allNotification = [
    CheckBoxState(title: 'การซื้อชีท'),
    CheckBoxState(title: 'บัญชีติดตาม'),
    CheckBoxState(title: 'การถามคำถาม'),
    CheckBoxState(title: 'การตอบคำถาม'),
    CheckBoxState(title: 'ความสำเร็จ'),
    CheckBoxState(title: 'เควสประจำวัน'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'การแจ้งเตือน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: isPortrait ? screenWidth * 0.04 : screenWidth * 0.024,
            bottom: isPortrait ? 0 : screenWidth * 0.02),
        child: ListView(
          children: [
            ...allNotification.map(SingleCheckBox).toList(),
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait ? screenWidth * 0.8 : screenWidth * 0.024,
                left: isPortrait ? screenWidth * 0.64 : screenWidth * 0.84,
                right: isPortrait ? screenWidth * 0.08 : screenWidth * 0.032,
              ),
              child: PrimaryButton(
                text: 'บันทึก',
                onPressed: () {
                  print('go go');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        activeColor: AppColors.secondary500,
        value: checkbox.value,
        title: Medium16px(text: checkbox.title),
        onChanged: (value) => setState(() => checkbox.value = value!),
      );
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
