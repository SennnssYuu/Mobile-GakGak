import 'package:flutter/material.dart';
import 'package:mobile_gakgak/constant/my_constant.dart';
import '_home_borrow.dart';

import 'package:mobile_gakgak/widget/appBackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NoScrollbarScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class HomeScreen extends StatefulWidget {
  final User userOBJ;
  final String user; // Firebase user
  const HomeScreen({
    super.key,
    required this.userOBJ,
    required this.user
    });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ScrollController verticalController;
  late ScrollController horizontal1Controller;
  late ScrollController horizontal2Controller;
  late ScrollController horizontal3Controller;

  @override
  void initState() {
    super.initState();
    verticalController = ScrollController();
    horizontal1Controller = ScrollController();
    horizontal2Controller = ScrollController();
    horizontal3Controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final bannerShown = prefs.getBool('login_banner_shown') ?? false;
      
      if (!bannerShown) {
        showLoginBanner(context, widget.user);
        prefs.setBool('login_banner_shown', true);
      }
    });
  }

  @override
  void dispose() {
    verticalController.dispose();
    horizontal1Controller.dispose();
    horizontal2Controller.dispose();
    horizontal3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 24.0),
          SizedBox(width: 16.0),
        ],
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
          size:24.0
          ),
        title: const Center(
          child: Text('Trainer CPN', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        ),
        backgroundColor: Color.fromRGBO(46, 46, 46, 1),
      ),
      body: Stack(
        children: [
          const AppBackground(),
          ScrollConfiguration(
          behavior: NoScrollbarScrollBehavior(),
          child: SingleChildScrollView(
            controller: verticalController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Daily Stats',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),

                  BigBorrowWidget(imageBorrow: 'images/Bo0.png'),

                  SizedBox(height: 8.0),
                  Text(
                    'Uma Inheritance',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RawScrollbar(
                    controller: horizontal1Controller,
                    thumbVisibility: false,
                    child: SingleChildScrollView(
                      controller: horizontal1Controller,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          BorrowWidget(imageBorrow: 'images/Bo1.png'),
                          SizedBox(width: 16.0),
                          BorrowWidget(imageBorrow: 'images/Bo2.png'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0
                  ),
                  Text(
                    'Club Leaderboard',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RawScrollbar(
                    controller: horizontal2Controller,
                    thumbVisibility: false,
                    child: SingleChildScrollView(
                      controller: horizontal2Controller,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MultiBorrowWidget(
                            text1: '#1',
                            text2: 'Eden',
                            text3: '30/30',
                            text4: '5.0 Bs',
                            borderColor:   Color.fromRGBO(226, 223, 64, 1),
                            bgColor:  Color.fromRGBO(36, 36, 36, 1),
                          ),
                          SizedBox(width: 16.0),
                          MultiBorrowWidget(
                            text1: '#2',
                            text2: 'Eden',
                            text3: '30/30',
                            text4: '4.2 Bs',
                            borderColor:   Color.fromRGBO(213, 213, 213, 1),
                            bgColor:  Color.fromRGBO(36, 36, 36, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Tools',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RawScrollbar(
                    controller: horizontal3Controller,
                    thumbVisibility: false,
                    child: SingleChildScrollView(
                      controller: horizontal3Controller,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ToolWidget(
                            text: 'Stamina Calculator',
                            borderColor:   Color.fromRGBO(226, 223, 64, 1),
                            bgColor:  Color.fromRGBO(36, 36, 36, 1),
                          ),
                          SizedBox(width: 16.0),
                          ToolWidget(
                            text: 'More',
                            borderColor:   Color.fromRGBO(96, 96, 96, 1),
                            bgColor:  Color.fromRGBO(83, 83, 83, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

void showLoginBanner(BuildContext context, String uName) {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;
  late AnimationController controller;

  entry = OverlayEntry(
    builder: (context) {
      controller = AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 350),
      );

      final animation = Tween<double>(
        begin: -80,
        end: 0,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );

      controller.forward();

      Future.delayed(const Duration(seconds: 2), () async {
        await controller.reverse();
        entry.remove();
        controller.dispose();
      });

      return Positioned(
        top: 40,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: animation,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, animation.value),
              child: child,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(208, 208, 208, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Logged in as "$uName"',
                style: headingStyle.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(entry);
}