// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:random_string/random_string.dart';

// class ResetPasswordService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   String otp = '';

//   void generateOTP() {
//     otp = randomAlphaNumeric(6); // Generate a 6-character OTP
//   }

//   Future<void> sendPasswordResetEmail() async {
//     try {
//       // Generate and store the OTP
//       generateOTP();

//       // Send the OTP in the email content
//       final emailContent = 'Your OTP for password reset is: $otp';

//       // Send the email (replace 'user@example.com' with the user's email)
//       await _auth.sendPasswordResetEmail(email: 'user@example.com');

//       // Handle email sent successfully (e.g., show a snackbar)
//     } catch (e) {
//       // Handle errors (e.g., show an error message)
//     }
//   }
// }
