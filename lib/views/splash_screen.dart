import 'package:flutter/material.dart';
import 'package:boardingadmissions/views/login_page.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0;
  double logoPosition = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), _fadeIn);
  }

  void _fadeIn() {
    if (mounted) { // Check if the widget is still mounted
      setState(() {
        opacityLevel = 1.0;
      });
      Timer(Duration(seconds: 2), _moveLogoUp);
    }
  }

  void _moveLogoUp() {
    if (mounted) { // Check if the widget is still mounted
      setState(() {
        logoPosition = -100.0; // Adjust the value for the desired position
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }
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
              AnimatedOpacity(
                duration: Duration(seconds: 2),
                opacity: opacityLevel,
                child: Image.asset(
                  'assets/logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                top: logoPosition,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your login content here
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
