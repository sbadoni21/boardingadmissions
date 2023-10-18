import 'package:flutter/material.dart';
import 'package:boardingadmissions/views/login_page.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0; // Initial opacity value for the logo
  double logoPosition = 0.0; // Initial position for the logo

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

    // Start a timer for logo position animation
    Timer(Duration(seconds: 2), _moveLogoUp);
  }

  void _moveLogoUp() {
    // Animate the position of the logo to move it up
    setState(() {
      logoPosition = -100.0; // Adjust the value for the desired position
    });

    // After a delay, navigate to the login page
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo with opacity animation
              AnimatedOpacity(
                duration:
                    Duration(seconds: 2), // Duration for the fade-in animation
                opacity: opacityLevel,
                child: Image.asset(
                  'assets/logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ),
    
              // Login content with position animation
              AnimatedPositioned(
                duration: Duration(seconds: 2), // Duration for position animation
                curve: Curves.easeInOut, // Adjust the curve as needed
                top: logoPosition,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your login content here
                    // For example, you can add TextFields, buttons, or any other widgets
                    // that you want to display as part of the login screen.
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
