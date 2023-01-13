import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../res/button.dart';
import '../res/colors.dart';
import '../res/components/form_field.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.032,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Medium20px(text: "ยินดีต้อนรับ!"),
                            SizedBox(height: screenHeight * 0.01),
                            Regular16px(text: "ล็อกอินเพื่อเข้าใช้งาน"),
                            SizedBox(height: screenHeight * 0.024),
                          ],
                        ),
                        Container(
                          height: screenWidth < 480
                              ? screenHeight * 0.18
                              : screenHeight * 0.36,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png')),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.096,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Regular16px(text: "E-mail"),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                // I delete username because currently it can't use username to login.
                                // E-mail
                                MyTextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter e-mail.'),
                                    EmailValidator(
                                        errorText:
                                            'Format of email is not correct.'),
                                  ]),
                                  onSaved: (value) {
                                    myUser.email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: "example@email.com",
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Regular16px(text: "รหัสผ่าน"),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                // Password
                                MyTextFormField(
                                  validator: RequiredValidator(
                                      errorText: 'Please enter password.'),
                                  onSaved: (value) {
                                    myUser.password = value;
                                  },
                                  obscureText: true,
                                  hintText: "รหัสผ่าน",
                                ),

                                SizedBox(
                                    height: screenWidth < 480
                                        ? screenHeight * 0.03
                                        : screenHeight * 0.06),
                                SizedBox(
                                  height: 40,
                                  width: screenWidth * 0.4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center,
                                      elevation: 0,
                                      backgroundColor: AppColors.tertiary500,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  // This procress is not create username into firebase yet.
                                                  email:
                                                      myUser.email.toString(),
                                                  password: myUser.password
                                                      .toString())
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg: 'Success login',
                                                gravity: ToastGravity.BOTTOM);
                                            formKey.currentState!.reset();
                                          });
                                          /*
                                              Change route code here.
                                            */
                                        } on FirebaseAuthException catch (e) {
                                          // debugPrint(e.message);
                                          Fluttertoast.showToast(
                                              msg: e.message.toString(),
                                              gravity: ToastGravity.BOTTOM);
                                        }
                                      }
                                    },
                                    child: const Regular16px(
                                      text: "เข้าสู่ระบบ",
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
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
                            SizedBox(width: screenWidth * 0.128),
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
                                margin: EdgeInsets.only(
                                    left: screenWidth * 0.048,
                                    right: screenWidth * 0.048),
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
                        SizedBox(
                          height: screenHeight * 0.016,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.045,
                              right: screenWidth * 0.045),
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
