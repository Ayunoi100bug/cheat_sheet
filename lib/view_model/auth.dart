import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/res/components/flushbar.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  CreateCollection myCollection = CreateCollection();

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
      await myCollection.createUserCollection(argUsername, argEmail, _user!.uid);
      AutoRouter.of(context).navigateNamed("/home/");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> loginWithEmail(BuildContext context, String argEmail, String argPassword) async {
    try {
      await _auth.signInWithEmailAndPassword(email: argEmail.toString().trim(), password: argPassword.toString().trim());
      AutoRouter.of(context).navigateNamed("/home/");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        AutoRouter.of(context).popAndPush(const LoginRoute());
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final User? user = (await _auth.signInWithCredential(credential)).user;
      await myCollection.createGoogleUserCollection(user);
      AutoRouter.of(context).navigateNamed("/home/");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.i.login(permissions: ['email, public_profile, user_photos']);
      if (loginResult.accessToken == null) {
        AutoRouter.of(context).popAndPush(const LoginRoute());
        return;
      }
      OAuthCredential? facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final User? user = (await _auth.signInWithCredential(facebookAuthCredential)).user;
      await myCollection.createFacebookUserCollection(user);
      AutoRouter.of(context).navigateNamed("/home/");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlushbarPopup.successFlushbarNoAppbar(context, FlushbarIcon.successIcon, "เข้าสู่ระบบสำเร็จ");
      });
    } on FirebaseAuthException catch (e) {
      FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.errorIcon, e.message.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    if (isLogged() == true) {
      int flag = 0;
      if (_user!.providerData[0].providerId == 'google.com') {
        await GoogleSignIn().signOut();
        await _auth.signOut();
        flag = 1;
      } else if (_user!.providerData[0].providerId == 'facebook.com') {
        await FacebookAuth.i.logOut();
        await _auth.signOut();
        flag = 1;
      } else {
        await _auth.signOut();
        flag = 1;
      }
      if (flag == 1) {
        AutoRouter.of(context).navigateNamed("/home/");
        Navigator.pop(context);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FlushbarPopup.errorFlushbarNoAppbar(context, FlushbarIcon.successIcon, "ออกจากระบบสำเร็จ");
        });
        flag = 0;
      }
    } else {
      print("That's illegal."); // Logout while not login, how can this be.
    }
  }
}
