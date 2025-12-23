import 'package:flutter/material.dart';

  class ProfileScreen extends StatelessWidget {
    const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7Q7EqY_tJt7qQ3h8VZGa4qQWDa063YysMw&s'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text("ZONA PLG", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text("ZONAPOLYGONGEN1@polygon.ac.th",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}