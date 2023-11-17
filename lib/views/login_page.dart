import 'dart:async';
import 'package:boardingadmissions/components/loading_screen.dart';
import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/password_reset_page.dart';
import 'package:boardingadmissions/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double logoPosition = 270.0;
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  @override
  void initState() {
    super.initState();

    // Start a timer for the logo position and content animation
    Timer(const Duration(seconds: 1), _animateLogoAndContent);
  }

  void _animateLogoAndContent() {
    // Animate the position of the logo to move it up
    setState(() {
      logoPosition = -5.0; // Adjust the value for the desired position
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Logo with position animation
                AnimatedPositioned(
                  duration: const Duration(
                      seconds: 1), // Duration for the position animation
                  curve: Curves.easeInOut, // Adjust the curve as needed
                  top: logoPosition,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/logo.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ),
    
                AnimatedOpacity(
                  duration: const Duration(
                      seconds: 1), // Duration for the fade-in animation
                  opacity: logoPosition == -5.0 ? 1.0 : 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 100),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(hintText: 'Email'),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: togglePasswordVisibility,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                              ),
                              child: const Text('Forgot password'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please enter both email and password"),
                              ),
                            );
                          } else {
                            User? result =
                                await AuthenticationServices().signIn(
                              emailController.text,
                              passwordController.text,
                            );
                            if (result != null) {
                              // Sign-in successful
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoadingScreen()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Sign-in failed. Please check your credentials and try again."),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: 200,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text("or login using"),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          'assets/googlelogo.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                     ElevatedButton(
    onPressed: () async {
      User? user = await AuthenticationServices()
          .signInWithGoogle();
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Google Sign-in failed."),
          ),
        );
      }
    },
    child: const Text(
      "Google",
    )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle the "Forgot Password" action here.
                              // You can navigate to the password reset page or perform any other action.
                            },
                            style: TextButton.styleFrom(),
                            child: const Text(
                              'New to boarding admissions?',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                          // Your button click logic here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue, backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.blue, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: 180,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}