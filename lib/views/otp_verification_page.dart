// // verify_otp_page.dart

// import 'package:boardingadmissions/views/password_reset_page.dart';
// import 'package:flutter/material.dart';
// import 'package:boardingadmissions/services/authentication_service.dart';

// class VerifyOTPPage extends StatefulWidget {
//   @override
//   _VerifyOTPPageState createState() => _VerifyOTPPageState();
// }

// class _VerifyOTPPageState extends State<VerifyOTPPage> {
//   TextEditingController otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verify OTP'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: otpController,
//               decoration: InputDecoration(hintText: 'Enter OTP'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final String otpEntered = otpController.text;

//                 if (otpEntered.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text("Please enter the OTP"),
//                   ));
//                 } else {
//                   bool isOTPValid = await AuthenticationServices()
//                       .validateOTP(otpEntered, otpSent);

//                   if (isOTPValid) {
//                     // Navigate to the password reset page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ResetPasswordPage(),
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text('Invalid OTP. Please try again.'),
//                     ));
//                   }
//                 }
//               },
//               child: Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
