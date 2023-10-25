

import 'package:email_validator/email_validator.dart'; // Import the email_validator package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_string/random_string.dart';

class AuthenticationServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during sign-in: $e");
      return null; // Sign-in failed
    }
  }

  // Send an OTP to the user's email
  Future<bool> sendOTP(String email) async {
    if (EmailValidator.validate(email)) {
      try {
        // Generate a random OTP
        String otp = randomAlphaNumeric(6); // 6-character OTP

        // You can send the OTP via email or other methods here
        // Example: SendOTPByEmail(email, otp);

        return true;
      } catch (e) {
        print('Failed to send OTP: $e');
        return false;
      }
    } else {
      print('Invalid email address');
      return false;
    }
  }

  // Validate the OTP entered by the user
  Future<bool> validateOTP(String otpEntered, String otpSent) async {
    return otpEntered == otpSent;
  }

  // Reset the password for the user
  Future<bool> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      return true;
    } catch (e) {
      print('Failed to reset password: $e');
      return false;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
    
  }
}


// For deleting account to be made as a option in settings bar after completeing
Future<void> deleteAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.delete();
      print("User account deleted successfully");
    } else {
      print("No user is currently signed in");
    }
  } catch (e) {
    print("Failed to delete user account: $e");
  }
}