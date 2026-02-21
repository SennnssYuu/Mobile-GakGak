import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_gakgak/widget/appBackground.dart';
import 'package:mobile_gakgak/screens/signIn_screen.dart';
// import 'package:mobile_gakgak/screens/profile_screen.dart';
// import '../constant/my_constant.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final List <PageViewModel> pages = [
    PageViewModel(
      title: "🔥Discover Trending Anime🔥",
      image: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset('assets/images/OnB1.png', height: 900.0, width: 900.0),
        ),
      ),
      body: "Explore the hottest anime airing this season. \nStay updated with top-rated shows and never miss the hype.",
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 18.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Colors.transparent,
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
    PageViewModel(
      title: "📌Build Your Watchlist📌",
      body: "Save your favorite anime, track episodes,\nand organize everything in one place.",
      image: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset('assets/images/OnB2.png', height: 900.0, width: 900.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 18.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Colors.transparent,
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
    PageViewModel(
      title: "🎥Experience Anime Like\nNever Before🎥",
      body: "Your personal anime universe — all in one app.",
      image: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset('assets/images/OnB3.png', height: 900.0, width: 900.0),
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
        bodyTextStyle: TextStyle(fontSize: 18.0, color: Color(0xFFFFFFFF)),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Colors.transparent,
        titlePadding: EdgeInsets.only(bottom: 8.0),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),

          IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
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
          skip: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              "Skip",
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(36, 36, 36, 1)
              )
            )
          ),
          showNextButton: true,
          next: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,child: const Icon(Icons.arrow_forward, color:  Color.fromRGBO(36, 36, 36, 1),)),
          showDoneButton: true,
          done: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,child: const Text("Get Started", style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromRGBO(36, 36, 36, 1)))),
        
          onDone: () async{
        
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('seen', true);
        
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
      ]
      ),
    );
  }
}