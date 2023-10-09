import 'dart:async';
import 'package:flutter/material.dart';
import 'package:boardingadmissions/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0; // Initial opacity value

  @override
  void initState() {
    super.initState();

    // Start a timer to gradually increase the opacity
    Timer(Duration(milliseconds: 500), _fadeIn);
  }

  void _fadeIn() {
    // Animate the opacity from 0.0 to 1.0 over 1 second
    setState(() {
      opacityLevel = 1.0;
    });

    // After a delay, trigger the fade-out animation and route redirection
    Timer(Duration(seconds: 2), _fadeOutAndRedirect);
  }

  void _fadeOutAndRedirect() {
    // Animate the opacity from 1.0 to 0.0 over 1 second
    setState(() {
      opacityLevel = 0.0;
    });

    // After the fade-out animation, navigate to the login page
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2), // Duration for the fade animation
          opacity: opacityLevel,
          child: Image.asset(
            'assets/logo.png', // Replace with the path to your image
            width: 200.0, // Adjust image size as needed
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
