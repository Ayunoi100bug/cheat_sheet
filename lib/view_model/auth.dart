import 'package:cheat_sheet/model/user.dart';
import 'package:cheat_sheet/view_model/create_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  Users myUser = Users(email: '', password: '', username: '', uid: '');
  CreateCollection myCollection = CreateCollection();

  Future<bool> isLogged() async {
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createUser(String argEmail, String argPassword) async {
    await _auth.createUserWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    );
    myCollection.createUserCollection();
  }

  Future<void> loginWithEmail(String argEmail, String argPassword) async {
    await _auth.signInWithEmailAndPassword(
      email: argEmail.toString().trim(),
      password: argPassword.toString().trim()
    );
  }

  Future<void> sighOut() async {
    await _auth.signOut();
  }
}
