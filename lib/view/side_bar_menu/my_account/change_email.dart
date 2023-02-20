import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/components/form_field.dart';
import '../../../res/typo.dart';
import '../../../view_model/auth.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService myAuth = AuthService();
  var currentPassword = "";
  var currentEmail = "";
  var newEmail = "";

  final currentPasswordController = TextEditingController();
  final currentEmailController = TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
  final newEmailController = TextEditingController();
  TextEditingController defaultText = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    currentEmailController.dispose();
    newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Regular20px(
          text: 'เปลี่ยนอีเมล์',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: isPortrait ? screenWidth * 0.048 : screenWidth * 0.024,
              left: screenWidth * 0.096,
              right: screenWidth * 0.096,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Medium20px(text: 'เปลี่ยนอีเมลล์'),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.03 : screenWidth * 0.015,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Regular16px(
                      text: "อีเมลล์ปัจจุบัน",
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.02 : screenWidth * 0.01,
                  ),
                  SizedBox(
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      child: MyTextFormField(
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        fontSize: 16,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: currentEmailController,
                        validator: (value) {
                          if (value!.isEmpty || value.isEmpty) {
                            return 'โปรดใส่อีเมลล์ปัจจุบัน';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.03 : screenWidth * 0.015,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Regular16px(
                      text: "รหัสผ่านปัจจุบัน",
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.02 : screenWidth * 0.01,
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: MyTextFormField(
                      obscureText: true,
                      fontSize: 16,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: currentPasswordController,
                      validator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return 'Please Enter Current Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.03 : screenWidth * 0.015,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Regular16px(
                      text: "อีเมลล์ใหม่",
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.02 : screenWidth * 0.01,
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: MyTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      fontSize: 16,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: newEmailController,
                      validator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return 'โปรดใส่อีเมลล์ใหม่';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.025,
                  ),
                  PrimaryButton(
                    text: 'บันทึก',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          currentPassword = currentPasswordController.text;
                          currentEmail = currentEmailController.text;
                          newEmail = newEmailController.text;
                        });
                        
                        myAuth.changeUserEmail(context, currentEmail, currentPassword, newEmail);
                      }
                    },
                  ),
                  SizedBox(
                    height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
