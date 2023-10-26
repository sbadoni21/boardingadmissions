import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:boardingadmissions/views/home_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    startLoading();
  }

  void startLoading() async {
    // Simulate loading for 2 seconds
    await Future.delayed(Duration(seconds: 2));

  
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(), // Replace 'HomePage' with the page you want to navigate to
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: double.infinity),
      child: RiveAnimation.asset("assets/riv_files/loadingscreen.riv"),
    );
  }
}
