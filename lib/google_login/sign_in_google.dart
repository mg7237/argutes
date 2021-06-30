import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  // login function
  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  //logout function
  Future<void> logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}

// data save to database after login users
class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static saveUser(dynamic user) async {
    Map<String, dynamic> userData = {
      'name': user.displayName,
      'image': user.photoURL,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'last login': user.metadata.lastSignInTime!.microsecondsSinceEpoch,
      'created at': DateTime.now(),
      'role': 'Free',
      'subjectPurchased': '',
      'valid': '',
    };

    final userRef = _db.collection('appleUsers').doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      });
    } else {
      await userRef.set(userData);
    }
  }
}
