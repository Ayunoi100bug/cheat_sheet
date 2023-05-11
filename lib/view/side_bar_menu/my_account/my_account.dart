import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/typo.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool firstValue = false;
  bool secondValue = false;
  bool thirdValue = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: Regular20px(
          text: 'บัญชีของฉัน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: isPortrait ? screenWidth * 0.052 : screenWidth * 0.04,
                left: isPortrait ? screenWidth * 0.044 : screenWidth * 0.06,
                right: isPortrait ? screenWidth * 0.032 : screenWidth * 0.06,
                bottom: isPortrait ? 0 : screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Medium20px(text: 'ข้อมูลทั่วไป'),
                SizedBox(
                  height: screenWidth * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Regular16px(text: 'อีเมล์'),
                    InkWell(
                      child: Row(
                        children: [
                          Regular16px(
                            text: _auth.currentUser!.email.toString(),
                            color: AppColors.black400,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.black400,
                            size: 16,
                          ),
                        ],
                      ),
                      onTap: () {
                        AutoRouter.of(context).push(ChangeEmailRoute());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.032,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Regular16px(text: 'รหัสผ่าน'),
                      Row(
                        children: [
                          Regular16px(
                            text: '********',
                            color: AppColors.black400,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.black400,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(ChangePasswordRoute());
                  },
                ),
                SizedBox(
                  height: screenWidth * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      text: 'บันทึก',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
