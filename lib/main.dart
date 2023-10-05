
import 'package:boardingadmissions/home_page.dart';
// import 'package:boardingadmissions/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:boardingadmissions/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // Use 'Key?' instead of 'super.key'

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), // Remove 'const' from LandingPage()
    );
  }
}
