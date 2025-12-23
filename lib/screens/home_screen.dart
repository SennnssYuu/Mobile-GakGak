import 'package:flutter/material.dart';

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
      appBar: AppBar(
        actions: const [
          Icon(Icons.search, color: Colors.black, size: 24.0),
          SizedBox(width: 16.0),
          Icon(Icons.exit_to_app, color: Colors.black, size: 24.0),
          SizedBox(width: 16.0),
        ],
        leading: const Icon(
          Icons.menu, color:
          Colors.black, size:
          24.0
          ),
        title: const Center(
          child: Text('Home Screen', style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'First Line',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 16.0
            ),
            Icon(
              Icons.settings,
              size: 48.0,
              color: Colors.blue
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                  child: const Text("Hello"),
                ),
                Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.yellow,
                  child: const Text("Hello"),
                ),
                Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.blue,
                  child: const Text("Hello"),
                ),
              
              ],
            ),
            SizedBox(
              height: 16.0
            ),
            CircleAvatar(
              radius: 55.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7Q7EqY_tJt7qQ3h8VZGa4qQWDa063YysMw&s',
                ),
              ),
            ),
          ],
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.green[50],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
