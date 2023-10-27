// import 'package:boardingadmissions/services/notification/notification_service.dart';
import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/chatapp.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/login_page.dart';
import 'package:boardingadmissions/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Global navigator key for navigation from NotificationService
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    logger.i("Firebase initialized successfully");
    runApp(MyApp());
    // NotificationService().initialize();
  } catch (e) {
    logger.e(e);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationServices authServices = AuthenticationServices();
  // final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boarding Admissions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey:
          navigatorKey,
          // home: ChatApp(),
           // Important for navigating from the NotificationService
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
            return HomePage();
          }

          print("User is not authenticated. Navigating to LoginPage.");
          return  LoginPage();
        },
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  ErrorApp(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      home: Scaffold(
        body: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }
}