import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during sign-in: $e");
      return null; // Sign-in failed
    }
  }
}
