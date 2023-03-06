import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:flutter/material.dart';
import '../../../res/button.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_appbar.dart';
import '../../../res/typo.dart';
import '../../../view_model/auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService myAuth = AuthService();
  var oldPassword = "";
  var newPassword = "";

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Regular20px(
          text: 'เปลี่ยนรหัสผ่าน',
          color: AppColors.white,
        ),
        backgroundColor: CustomAppBar.appBarColor,
      ),
      body: SafeArea(
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
                Medium20px(text: 'เปลี่ยนรหัสผ่าน'),
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
                        return 'โปรดกรอกรหัสผ่านปัจจุบัน';
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
                    text: "รหัสผ่านใหม่",
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
                    controller: newPasswordController,
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'โปรดกรอกรหัสผ่านใหม่';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: isPortrait ? screenWidth * 0.04 : screenWidth * 0.03,
                ),
                PrimaryButton(
                  text: 'บันทึก',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        oldPassword = currentPasswordController.text;
                        newPassword = newPasswordController.text;
                      });
                      myAuth.changeUserPassword(context, oldPassword, newPassword);
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
    );
  }
}
