import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:cheat_sheet/view_model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../res/colors.dart';
import '../res/gap_dimension.dart';
import '../res/typo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '', subject: []);
  AuthService myAuth = AuthService();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: screenHeight * GapDimension.h0_032,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Medium20px(text: "ยินดีต้อนรับ!"),
                        SizedBox(height: screenHeight * GapDimension.h0_01),
                        const Regular16px(text: "สร้างบัญชีเพื่อเข้าใช้งาน"),
                        SizedBox(height: screenHeight * GapDimension.h0_024),
                      ],
                    ),
                    Container(
                      height: screenWidth < 480 ? screenHeight * GapDimension.h0_18 : screenHeight * GapDimension.h0_36,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/logo.png')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * GapDimension.w0_096,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Regular16px(text: "ชื่อ"),
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_01),
                            // Username
                            MyTextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: RequiredValidator(errorText: 'โปรดกรอกชื่อของคุณ.'),
                              onSaved: (value) {
                                myUser.username = value!;
                              },
                              hintText: "ชื่อ",
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_02),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Regular16px(text: "E-mail"),
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_01),
                            // E-mail
                            MyTextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'โปรดกรอกอีเมลล์'),
                                EmailValidator(errorText: 'รูปแบบอีเมลล์ไม่ถูกต้อง'),
                              ]),
                              onSaved: (value) {
                                myUser.email = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              hintText: "example@email.com",
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_02),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Regular16px(text: "รหัสผ่าน"),
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_01),
                            // Password
                            MyTextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: RequiredValidator(errorText: 'โปรดกรอกรหัสผ่าน'),
                              onSaved: (value) {
                                myUser.password = value!;
                              },
                              obscureText: true,
                              hintText: "รหัสผ่าน",
                              helperText: "ต้องใช้ตัวอักษร 6-12 ตัวอักษร",
                            ),
                            SizedBox(height: screenHeight * GapDimension.h0_03),
                            SizedBox(
                              height: 40,
                              width: screenWidth * GapDimension.w0_4,
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
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await myAuth.createUserWithEmail(context, myUser.email, myUser.password, myUser.username).then(
                                      (value) {
                                        _formKey.currentState!.reset();
                                      },
                                    );
                                  }
                                },
                                child: const Regular16px(
                                  text: "ลงชื่อเข้าใช้งาน",
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * GapDimension.h0_02),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * GapDimension.w0_048, right: screenWidth * GapDimension.w0_048),
                      child: const Divider(
                        thickness: 1,
                      ),
                    ),
                    const Regular12px(
                      text: "เข้าสู่ระบบด้วย",
                      color: AppColors.black600,
                    ),
                    SizedBox(
                      height: screenHeight * GapDimension.h0_01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * GapDimension.w0_044, right: screenWidth * GapDimension.w0_044),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await myAuth.loginWithGoogle(context);
                            },
                            icon: Image.asset(
                              "assets/images/google.png",
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await myAuth.loginWithFacebook(context);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
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
                          onPressed: () {
                            AutoRouter.of(context).replace(const LoginRoute());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
