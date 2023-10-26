import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:boardingadmissions/views/home_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

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
    await Future.delayed(const Duration(seconds: 2));

  
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Replace 'HomePage' with the page you want to navigate to
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: double.infinity),
      child: const RiveAnimation.asset("assets/riv_files/loadingscreen.riv"),
    );
  }
}
