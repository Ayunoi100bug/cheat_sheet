import 'package:cheat_sheet/model/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../res/colors.dart';
import '../res/typo.dart';

class RegisterScreen extends StatefulWidget {
  // const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  Users myUser = Users(username:'', email: '', password: '');
  // RegisterScreen({super.key});

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
                    Medium20px(text: "ยินดีต้อนรับ!"),
                    SizedBox(height: 4),
                    Regular16px(text: "สร้างบัญชีเพื่อเข้าใช้งาน"),
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
                      makeInput(label: "ชื่อ", onSaved: (value) {
                        myUser.username = value;
                      },),
                      makeInput(label: "E-mail", keyboardType: TextInputType.emailAddress, onSaved: (value) {
                        myUser.email = value;
                      },),
                      makeInput(label: "รหัสผ่าน", obscureText: true, onSaved: (value) {
                        myUser.password = value;
                      },),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      height: 40,
                      minWidth: 160,
                      color: AppColors.tertiary500,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Regular16px(
                        text: "ลงชื่อเข้าใช้งาน",
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()){
                          formKey.currentState?.save();
                          // debugPrint("User name is: ${myUser.username}");
                          // debugPrint("Email is: ${myUser.email}");
                          // debugPrint("Password is: ${myUser.password}");
                        }
                      },
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
                        text: "เข้าสู่ระบบ",
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

  Widget makeInput({label, obscureText = false, keyboardType, onSaved}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'BaiJamjuree',
            fontSize: 16,
            color: AppColors.black800,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
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
