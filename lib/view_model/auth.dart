import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Users myUser = Users(email: '', password: '', username: '', uid: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Future<void> createUser(String argEmail, String argPassword) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    ); 
    myUser.storeInFirestore();
  }

  Future<void> loginWithEmail(String argEmail, String argPassword) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    );
  }
}
