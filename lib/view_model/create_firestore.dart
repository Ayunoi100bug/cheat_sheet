import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateCollection {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '');
  Sheets mySheet =
      Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, authorId: '');

  Future<void> createUserCollection(String argUsername, String argEmail, String argUid) async {
    await _firestoreDb.collection("users").doc(argUid).set({
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': myUser.profileImage.toString().trim(),
      'follower': myUser.follower,
      'following': myUser.following,
    });
  }

  Future<void> createGoogleUserCollection(User? currentuser) async {
    final userRef = _firestoreDb.collection("users").doc(currentuser?.uid);
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      await _firestoreDb.collection("users").doc(currentuser?.uid).set({
        'username': currentuser?.displayName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': myUser.profileImage.toString().trim(),
        'follower': myUser.follower,
        'following': myUser.following,
      });
    }
  }

  Future<void> createSheetCollection(String argSheetName, String argDetailSheet,
      bool argSheetType, int? argPrice, String argUid) async {
    await _firestoreDb.collection("sheet").doc(mySheet.sid).set({
      'sheetName': argSheetName.toString().trim(),
      'detailSheet': argDetailSheet.toString().trim(),
      'sheetTypeFree': argSheetType,
      'price': argPrice,
      'uid': argUid,
    });
  }
}
