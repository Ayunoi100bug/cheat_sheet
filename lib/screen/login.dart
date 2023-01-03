import 'package:cheat_sheet/widgets/body.dart';
import 'package:cheat_sheet/widgets/body_small.dart';
import 'package:cheat_sheet/widgets/button_text.dart';
import 'package:cheat_sheet/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../res/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 32),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Header(text: "ยินดีต้อนรับ!"),
                    SizedBox(height: 4),
                    ButtonText(text: "ล็อกอินเพื่อเข้าใช้งาน"),
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
                    MaterialButton(
                      height: 44,
                      minWidth: 116,
                      color: AppColors.tertiary500,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ButtonText(
                        text: "เข้าสู่ระบบ",
                        color: AppColors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const BodySmall(
                        text: "เข้าสู่ระบบด้วยเกสท์",
                        color: AppColors.tertiary500,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 48,
                    ),
                    TextButton(
                      child: const BodySmall(
                        text: "ลืมรหัสผ่าน?",
                        color: AppColors.tertiary500,
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
                const BodySmall(
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
                    TextButton(
                      child: const BodySmall(
                        text: "ยังไม่มีบัญชีใช่ไหม?",
                        color: AppColors.black600,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    TextButton(
                      child: const BodySmall(
                        text: "สมัครสมาชิก",
                        color: AppColors.tertiary500,
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
        Body(
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
