import 'package:flutter/material.dart';
import '../widget/_home_borrow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(36, 36, 36, 1),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color.fromRGBO(33, 33, 33, 1),
              Color.fromRGBO(27, 27, 27, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Row(
                children: [
                  BorrowWidget(imageBorrow: 'images/Bo1.png'),
                  SizedBox(width: 16.0),
                  BorrowWidget(imageBorrow: 'images/Bo2.png'),
                ],
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
              Row(
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
              Row(
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
            ],
          ),
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
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
