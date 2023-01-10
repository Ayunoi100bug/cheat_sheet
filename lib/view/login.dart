import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../res/button.dart';
import '../res/colors.dart';
import '../res/typo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Users myUser = Users();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                // I delete username because currently it can't use username to login.
                                // E-mail
                                TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter e-mail.'),
                                    EmailValidator(
                                        errorText:
                                            'Format of email is not correct.'),
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    myUser.email = value;
                                  },
                                ),
                                // Password
                                TextFormField(
                                  validator: RequiredValidator(
                                      errorText: 'Please enter password.'),
                                  obscureText: true,
                                  onSaved: (value) {
                                    myUser.password = value;
                                  },
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
                                        text: "เข้าสู่ระบบ",
                                        color: AppColors.white,
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          try {
                                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                              // This procress is not create username into firebase yet.
                                              email: myUser.email.toString(),
                                              password: myUser.password.toString()
                                            ).then((value) {
                                              Fluttertoast.showToast(
                                                msg: 'Success login',
                                                gravity: ToastGravity.BOTTOM
                                              );
                                              formKey.currentState!.reset();
                                            });
                                            /*
                                              Change route code here.
                                            */
                                          } on FirebaseAuthException catch (e) {
                                            // debugPrint(e.message);
                                            Fluttertoast.showToast(
                                              msg: e.message.toString(),
                                              gravity: ToastGravity.BOTTOM
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
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
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
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

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}

// เก็บไว้ให้บุ๊ค
/*
import 'dart:developer';

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
*/