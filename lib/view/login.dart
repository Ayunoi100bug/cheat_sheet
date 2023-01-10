import 'package:cheat_sheet/res/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../res/colors.dart';
import '../res/typo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  void _onButtonPressed() {
    print('Button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 32),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Bold24px(text: "ยินดีต้อนรับ!"),
                    SizedBox(height: 4),
                    Regular16px(text: "ล็อกอินเพื่อเข้าใช้งาน"),
                    SizedBox(height: 25),
                  ],
                ),
                Container(
                  height: 170,
                  width: 170,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                    children: <Widget>[
                      makeInput(label: "E-mail"),
                      makeInput(label: "รหัสผ่าน"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      text: "เข้าสู่ระบบ",
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Regular12px(
                        text: "เข้าสู่ระบบด้วยเกสท์",
                        color: AppColors.tertiary500,
                        underline: true,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 48,
                    ),
                    Text(
                      "data",
                      style: TextStyle(fontFamily: "BaiJamjuree"),
                    ),
                    TextButton(
                      child: const Regular12px(
                        text: "ลืมรหัสผ่าน?",
                        color: AppColors.tertiary500,
                        underline: true,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: const Divider(
                          thickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const Regular12px(
                  text: "เข้าสู่ระบบด้วย",
                  color: AppColors.black600,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.line,
                          color: Colors.green,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Regular12px(
                      text: "ยังไม่มีบัญชีใช่ไหม?",
                      color: AppColors.black600,
                    ),
                    TextButton(
                      child: const Regular12px(
                        text: "สมัครสมาชิก",
                        color: AppColors.tertiary500,
                        underline: true,
                      ),
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

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Medium16px(
          text: label,
          color: Colors.black,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: const EdgeInsets.all(8),
            hintText: label,
            hintStyle: const TextStyle(fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black400),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black400),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
