import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../res/colors.dart';
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
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                // Username
                                TextFormField(
                                  /**
                                  * * validator is a prompt when not fill the form, if you already have some of this handling please remove it.
                                  */
                                  validator: RequiredValidator(
                                      errorText: 'Please enter username.'),
                                  onSaved: (value) {
                                    myUser.username = value;
                                  },
                                ),
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
                                        text: "ลงชื่อเข้าใช้งาน",
                                        color: AppColors.white,
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          try {
                                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                              // This procress is not create username into firebase yet.
                                              email: myUser.email.toString(),
                                              password: myUser.password.toString()
                                            ).then((value) {
                                              Fluttertoast.showToast(
                                                msg: 'Success create user',
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
        });
  }
}

// เก็บไว้ให้บุ๊ค
/*
import 'package:cheat_sheet/model/user.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Users myUser = Users();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีผู้ใช้'),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('E-mail', style: TextStyle(fontSize: 20),),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      myUser.email = value;
                    },
                  ),
                  const SizedBox(height: 15,),
                  const Text('Password', style: TextStyle(fontSize: 20),),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      myUser.password = value;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('ลงทะเบียน', style: TextStyle(fontSize: 20),),
                      onPressed: () {
                        formKey.currentState?.save();
                        debugPrint('Username is: ${myUser.email}');
                        debugPrint('Password is: ${myUser.password}');
                      },
                    ),
                  ),
                ],
              ),
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
*/