import 'package:cheat_sheet/model/sheet.dart';
import 'package:cheat_sheet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateCollection {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Users myUser = Users(email: '', password: '', username: '', uid: '', profileImage: '');
  Sheets mySheet =
      Sheets(sheetName: '', detailSheet: '', sheetTypeFree: true, authorId: '');

  Future<void> createUserCollection(String argUsername, String argEmail, String argUid) async {
    const String defaultPath = "images/default_profile.png";
    final Reference storageRef = _storage.ref().child(defaultPath);
    final String url = await storageRef.getDownloadURL();
    await _firestoreDb.collection("users").doc(argUid).set({
      'username': argUsername.toString().trim(),
      'email': argEmail.toString().trim(),
      'uid': argUid.toString().trim(),
      'profileImage': url,
      'follower': myUser.follower,
      'following': myUser.following,
    });
  }

  Future<void> createOauthUserCollection(User? currentuser) async {
    final userRef = _firestoreDb.collection("users").doc(currentuser?.uid);
    DocumentSnapshot userDoc = await userRef.get();
    if (!userDoc.exists) {
      String? fullName = currentuser?.displayName;
      List<String>? cutName = fullName?.split(" ");
      String? firstName = cutName?[0];
      await _firestoreDb.collection("users").doc(currentuser?.uid).set({
        'username': firstName,
        'email': currentuser?.email,
        'uid': currentuser?.uid,
        'profileImage': currentuser?.photoURL,
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
