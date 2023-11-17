import 'dart:async';
import 'package:boardingadmissions/components/loading_screen.dart';
import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/password_reset_page.dart';
import 'package:boardingadmissions/views/signup_page.dart';
import 'package:boardingadmissions/views/testdescription_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class testLoginPage extends StatefulWidget {
  const testLoginPage({super.key});

  @override
  testLoginPageState createState() => testLoginPageState();
}

class testLoginPageState extends State<testLoginPage> {
  double logoPosition = 270.0;
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.black),
                            decoration:
                                const InputDecoration(hintText: 'Email'),
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
                              content:
                                  Text("Please enter both email and password"),
                            ),
                          );
                        } else {
                          User? result = await AuthenticationServices().signIn(
                            emailController.text,
                            passwordController.text,
                          );
                          if (result != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TestDescriptionPage()),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
