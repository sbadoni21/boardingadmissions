import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInWithGoogle() async {
  try {
     final GoogleSignIn googleSignIn = GoogleSignIn();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Check if the user canceled the sign-in
    if (googleUser == null) {
      print('Google Sign-In canceled by user');
      return null; // Return null or handle it as needed
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential using GoogleAuthProvider.credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print('Google Sign-In Success');
    return userCredential.user;
  } catch (error) {
    print('Google Sign-In Error: $error');
    return null; // Return null or handle the error as needed
  }
}
