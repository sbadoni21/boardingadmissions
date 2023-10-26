import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/login_page.dart';
import 'package:boardingadmissions/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAVWrB9v-jqhkurev2Bbqf8bRyskX1djWY",
        appId: "1:231034076515:android:1c99224cdd38922cc56756",
        messagingSenderId: "231034076515",
        projectId: "boarding-admissions",
      ),
    );
    logger.i("connected");
    runApp(const MyApp());
  } catch (e) {
    logger.e(e);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationServices authServices = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boarding Admissions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: authServices.firebaseAuth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasError) {
            print("Error with the stream: ${snapshot.error}");
            return const Center(child: Text("An error occurred."));
          }

          if (snapshot.hasData && snapshot.data != null) {
            print("User is authenticated. Navigating to HomePage.");
            return const HomePage();
          }

          print("User is not authenticated. Navigating to LoginPage.");
          return const LoginPage();
        },
      ),
    );
  }
}