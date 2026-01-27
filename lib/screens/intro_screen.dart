import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_gakgak/screens/home_screen.dart';
// import 'package:mobile_gakgak/screens/profile_screen.dart';
// import '../constant/my_constant.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final List <PageViewModel> pages = [
    PageViewModel(
      title: "View the stats",
      image: Center(
        child: Image.asset('images/OnB1.png', height: 900.0, width: 900.0),
      ),
      body: "An all in one tool for trainer to min/max their runs. Fans stat for your club.",
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Color.fromRGBO(36, 36, 36, 1),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
    PageViewModel(
      title: "Tier list",
      body: "Support Card, build, and current inherant meta.",
      image: Center(
        child: Image.asset('images/OnB2.png', height: 900.0, width: 900.0),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Color.fromRGBO(36, 36, 36, 1),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
    PageViewModel(
      title: "Get started!",
      body: "Browse the app and enjoy all the features we offer without needing to login or sign up.",
      image: Center(
        child: Image.asset('images/OnB3.png', height: 900.0, width: 900.0),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Color.fromRGBO(36, 36, 36, 1),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        dotsDecorator: DotsDecorator(
          color: Colors.grey,
          activeColor: Color.fromRGBO(36, 36, 36, 1),
          size: const Size(10.0, 10.0),
          activeSize: const Size(22.0, 10.0),
          spacing: EdgeInsets.all(4.0),
          ),
        scrollPhysics: NeverScrollableScrollPhysics(),
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(36, 36, 36, 1))),
        showNextButton: true,
        next: const Icon(Icons.arrow_forward, color:  Color.fromRGBO(36, 36, 36, 1),),
        showDoneButton: true,
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromRGBO(36, 36, 36, 1))),

        onDone: () async{

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('seen', true);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}