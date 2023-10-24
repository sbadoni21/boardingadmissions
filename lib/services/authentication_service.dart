import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_string/random_string.dart';

class AuthenticationServices {
  static final AuthenticationServices _instance =
      AuthenticationServices._privateConstructor();

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  // Private constructor
  AuthenticationServices._privateConstructor()
      : firebaseAuth = FirebaseAuth.instance,
        googleSignIn = GoogleSignIn();

  // Public factory constructor
  factory AuthenticationServices() {
    return _instance;
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
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

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        return null; // User cancelled Google SignIn
      }
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null; // Sign-in failed
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      print(AuthenticationServices()
          .firebaseAuth
          .currentUser); // This should print null after logout
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
}