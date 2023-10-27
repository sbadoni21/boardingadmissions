
import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                const String email =
                    ""; // Get the user's email from where you've stored it (e.g., in a variable, TextEditingController, etc.)
                final String newPassword = newPasswordController.text;

                if (newPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please enter both email and password"),
                  ));
                } else {
                  // Call a method to reset the password
                  bool passwordReset =
                      await AuthenticationServices().resetPassword(newPassword);

                  if (passwordReset) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password reset link sent via email'),
                    ));
                    // You can navigate to the login page or perform other actions here.
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Failed to reset the password. Please try again.'),
                    ));
                  }
                }
              },
              child: const Text('Send Password Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}