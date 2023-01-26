import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  CreateCollection myCollection = CreateCollection();

  Future<void> createUserWithEmail(String argEmail, String argPassword, String argUsername) async {
    UserCredential result =  await _auth.createUserWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    );
    User? user = result.user;
    user!.updateDisplayName(argUsername);
    await myCollection.createUserCollection(argUsername, argEmail, _auth.currentUser!.uid);
  }

  Future<void> loginWithEmail(String argEmail, String argPassword) async {
    await _auth.signInWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    );
  }

  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    final User? user = (await _auth.signInWithCredential(credential)).user;
    await myCollection.createOauthUserCollection(user);
  }

  Future<void> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    OAuthCredential? facebookAuthCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.token
    );
    final User? user = (await _auth.signInWithCredential(facebookAuthCredential)).user;
    await myCollection.createOauthUserCollection(user);
  }

  Future logOut() async {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }
}
