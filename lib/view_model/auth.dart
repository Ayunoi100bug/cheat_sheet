import 'package:cheat_sheet/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Users myUser = Users();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: myUser.email.toString(),
      password: myUser.password.toString()
    ); 
    myUser.storeInFirestore();
  }

  Future<void> loginWithEmail() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: myUser.email.toString(),
      password: myUser.password.toString()
    );
  }
}