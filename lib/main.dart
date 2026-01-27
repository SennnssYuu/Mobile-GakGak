import 'package:flutter/material.dart';
import 'package:mobile_gakgak/screens/signUp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/profile_screen.dart';
import 'screens/intro_screen.dart';

bool seen = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

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
      home: seen == true ? ProfileScreen() : IntroScreen(),
    );
  }
}