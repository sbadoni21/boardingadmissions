import 'package:boardingadmissions/chat.dart';
import 'package:boardingadmissions/home_page.dart';
import 'package:boardingadmissions/login_page.dart';
import 'package:boardingadmissions/notification.dart';
import 'package:boardingadmissions/profile_page.dart';
import 'package:boardingadmissions/schools_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:boardingadmissions/components/search_bar.dart';
import 'package:logger/logger.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  try{
    await Firebase.initializeApp();
    logger.i("connected");
  }
  catch(e){
    logger.e(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
