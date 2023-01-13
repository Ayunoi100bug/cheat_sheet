import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/form_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                  top: screenHeight * GapDimension.h0_032,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Medium20px(text: "ยินดีต้อนรับ!"),
                          SizedBox(height: GapDimension.h0_01),
                          const Regular16px(text: "สร้างบัญชีเพื่อเข้าใช้งาน"),
                          SizedBox(height: GapDimension.h0_024),
                        ],
                      ),
                      Container(
                        height: screenWidth < 480
                            ? GapDimension.h0_18
                            : GapDimension.h0_36,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: GapDimension.w0_096,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Regular16px(text: "ชื่อ"),
                              ),
                              SizedBox(height: GapDimension.h0_01),
                              // Username
                              MyTextFormField(
                                validator: RequiredValidator(
                                    errorText: 'Please enter username.'),
                                onSaved: (value) {
                                  myUser.username = value;
                                },
                                hintText: "ชื่อ",
                              ),
                              SizedBox(height: GapDimension.h0_02),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Regular16px(text: "E-mail"),
                              ),
                              SizedBox(height: GapDimension.h0_01),
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
                              SizedBox(height: GapDimension.h0_02),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Regular16px(text: "รหัสผ่าน"),
                              ),
                              SizedBox(height: GapDimension.h0_01),
                              // Password
                              MyTextFormField(
                                validator: RequiredValidator(
                                    errorText: 'Please enter password.'),
                                onSaved: (value) {
                                  myUser.password = value;
                                },
                                obscureText: true,
                                hintText: "รหัสผ่าน",
                                helperText: "ต้องใช้ตัวอักษร 6-12 ตัวอักษร",
                              ),
                              SizedBox(height: GapDimension.h0_03),
                              SizedBox(
                                height: 40,
                                width: GapDimension.w0_4,
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
                                            .createUserWithEmailAndPassword(
                                                // This procress is not create username into firebase yet.
                                                email: myUser.email.toString(),
                                                password:
                                                    myUser.password.toString())
                                            .then(
                                          (value) {
                                            Fluttertoast.showToast(
                                                msg: 'Success create user',
                                                gravity: ToastGravity.BOTTOM);
                                            formKey.currentState!.reset();
                                          },
                                        );
                                        /*
                                              Change route code here.
                                            */
                                      } on FirebaseAuthException catch (e) {
                                        // debugPrint(e.message);
                                        Fluttertoast.showToast(
                                          msg: e.message.toString(),
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }
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
                      SizedBox(height: GapDimension.h0_02),
                      Container(
                        margin: EdgeInsets.only(
                            left: GapDimension.w0_048,
                            right: GapDimension.w0_048),
                        child: const Divider(
                          thickness: 1,
                        ),
                      ),
                      const Regular12px(
                        text: "เข้าสู่ระบบด้วย",
                        color: AppColors.black600,
                      ),
                      SizedBox(
                        height: GapDimension.h0_01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: GapDimension.w0_044,
                            right: GapDimension.w0_044),
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
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
