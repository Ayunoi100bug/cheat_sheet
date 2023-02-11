import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/typo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'เปลี่ยนรหัสผ่าน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenWidth * 0.048),
          child: Column(
            children: [
              Medium20px(text: 'เปลี่ยนรหัสผ่าน'),
              SizedBox(
                height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.024,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: isPortrait ? screenWidth * 0.08 : screenWidth * 0.24,
                    right: isPortrait ? 0 : screenWidth * 0.24),
                child: Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.016),
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black800),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'รหัสผ่านเก่า',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.024,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: isPortrait ? screenWidth * 0.08 : screenWidth * 0.24,
                    right: isPortrait ? 0 : screenWidth * 0.24),
                child: Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.016),
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black800),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'รหัสผ่านใหม่',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: isPortrait ? screenWidth * 1.2 : screenWidth * 0.024,
                  left: isPortrait ? screenWidth * 0.6 : screenWidth * 0.4,
                  right: isPortrait ? screenWidth * 0.044 : screenWidth * 0.032,
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
      ),
    );
  }
}
