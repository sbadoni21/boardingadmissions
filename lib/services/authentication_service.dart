
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart'; // Import the email_validator package
import 'package:random_string/random_string.dart';

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
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      // The user will receive an email with a link to reset their password

      // You can also implement password change logic here if required
      // Example: firebaseAuth.confirmPasswordReset(code: email, newPassword: newPassword);

      return true;
    } catch (e) {
      print('Failed to reset password: $e');
      return false;
    }
  }
}
