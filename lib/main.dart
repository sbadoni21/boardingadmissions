import 'package:boardingadmissions/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAVWrB9v-jqhkurev2Bbqf8bRyskX1djWY",
        appId: "1:231034076515:android:1c99224cdd38922cc56756",
        messagingSenderId: "231034076515",
        projectId: "boarding-admissions",
      ),
    );
    logger.i("connected");
  } catch (e) {
    logger.e(e);
  }
  runApp(MyApp());
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp())
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
