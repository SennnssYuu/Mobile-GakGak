import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gakgak/screens/intro_screen.dart';
import 'package:mobile_gakgak/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screens/main_screen.dart';


bool seen = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  seen = prefs.getBool('seen') ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mobile app',
      // home: seen == true ? ProfileScreen() : IntroScreen(),
      home: IntroScreen(),
    );
  }
}