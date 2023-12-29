// ignore_for_file: avoid_print, prefer_final_fields, unused_element

import 'package:find_lost_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  //------------Create Signup Function

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-alreday-in-use") {
        showToast(message: "The email address is already use.");
      } else {
        showToast(message: "some error Occured : ${e.code}");
      }
    }
    return null;
  }

  //------------Create login Function

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        showToast(message: "Invalid email pr password");
      } else {
        showToast(message: "some error Occured : ${e.code}");
      }

      return null;
    }
  }

    Future<void> _signOut() async {
    try {
      await _auth.signOut();
      showToast(message : "User signed out");
      
    } catch (e) {

      showToast(message: "Error signing out: $e");
    }
  }

}
