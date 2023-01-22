import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '');
  CreateCollection myCollection = CreateCollection();

  Future<bool> isLogged() async {
    User? user = await _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

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
    myCollection.createGoogleUserCollection(user);
  }

  Future logOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
