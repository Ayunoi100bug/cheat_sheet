import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This isn't work because don't have uid and code parameter in user.dart
class AuthService {
  Users myUser = Users();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _users(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users?> get user {
    return _auth.authStateChanges().map(_users);
  }

  Future sighInEmailPassword(Users _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _login.email.toString(),
        password: _login.password.toString());
        User? user = userCredential.user;
        return _users(user);
    } on FirebaseAuthException catch (e) {
      return Users(code: e.code, uid: null);
    }
  }

  Future registerEmailPassword(Users _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      return _users(user);
    } on FirebaseAuthException catch (e) {
      return Users(code: e.code, uid: null);
    } catch (e) {
      return Users(code: e.toString(), uid: null);
    }
  }

  Future sighOut() async {
    try {
      return await _auth.signOut(); 
    } catch (e) {
      return null;
    }
  }
}