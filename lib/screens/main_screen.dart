import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_gakgak/screens/setting_screen.dart';

import 'home_screenAnime.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final User userOBJ;
  final String user; // Firebase user
  const MainScreen({
    super.key,
    required this.userOBJ,
    required this.user
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      TopSeasonAnimeScreen(),
      ProfileScreen(
        userOBJ: widget.userOBJ,
      ),
      SettingScreen(),// change to setting later on
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: const Color.fromARGB(255, 80, 80, 80),
      backgroundColor: Color.fromRGBO(46, 46, 46, 1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}