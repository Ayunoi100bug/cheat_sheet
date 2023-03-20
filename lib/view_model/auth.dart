import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:cheat_sheet/view_model/update_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../res/components/popup_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '', subject: []);
  CreateCollection createFS = CreateCollection();

  bool isLogged() {
    if (_user == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> createUserWithEmail(BuildContext context, String argEmail, String argPassword, String argUsername) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: argEmail.toString().trim(), password: argPassword.toString().trim());
      User? user = result.user;
      user!.updateDisplayName(argUsername);
      await createFS.createUserCollection(argUsername, argEmail, user.uid).then((value) {
        AutoRouter.of(context).navigateNamed("/home/");
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
        });
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> loginWithEmail(BuildContext context, String argEmail, String argPassword) async {
    try {
      await _auth.signInWithEmailAndPassword(email: argEmail.toString().trim(), password: argPassword.toString().trim());
      await UpdateCollection().updateUserData().then((value) {
        AutoRouter.of(context).navigateNamed("/home/");
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
        });
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> changeUserPassword(BuildContext context, String currentPassword, String newPassword) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      await _auth.currentUser?.updatePassword(newPassword);
      await UpdateCollection().updateUserData().then((value) async {
        AutoRouter.of(context).popUntilRoot();
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เปลี่ยนรหัสผ่านสำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Popup_error(context, "รหัสผ่านปัจจุบันไม่ถูกต้อง", "โปรดลองใหม่อีกครั้ง"),
      );
    }
  }

  Future<void> changeUserEmail(BuildContext context, String currentEmail, String currentPassword, String newEmail) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      await _auth.currentUser?.updateEmail(newEmail);
      await UpdateCollection().updateUserData().then((value) {
        AutoRouter.of(context).popUntilRoot();
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เปลี่ยนอีเมลล์สำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Popup_error(context, "รหัสผ่านไม่ถูกต้อง", "โปรดลองใหม่อีกครั้ง"),
      );
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null && context.mounted) {
        AutoRouter.of(context).popAndPush(const LoginRoute());
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final User? user = (await _auth.signInWithCredential(credential)).user;
      await createFS.createGoogleUserCollection(user);
      await UpdateCollection().updateUserData().then((value) {
        AutoRouter.of(context).navigateNamed("/home/");
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
        });
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.i.login(permissions: ['email, public_profile, user_photos']);
      if (loginResult.accessToken == null && context.mounted) {
        AutoRouter.of(context).popAndPush(const LoginRoute());
        return;
      }
      OAuthCredential? facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final User? user = (await _auth.signInWithCredential(facebookAuthCredential)).user;
      await createFS.createFacebookUserCollection(user);
      await UpdateCollection().updateUserData().then((value) {
        AutoRouter.of(context).navigateNamed("/home/");
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
        });
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    await Future.wait([GoogleSignIn().signOut(), FacebookAuth.i.logOut(), _auth.signOut()]).then((value) {
      Navigator.pop(context);
      AutoRouter.of(context).navigateNamed("/home/");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "ออกจากระบบสำเร็จ");
      });
    });
  }
}
