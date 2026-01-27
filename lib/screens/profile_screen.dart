import 'package:flutter/material.dart';
import 'package:mobile_gakgak/constant/my_constant.dart';
import '../widget/_menu_profile.dart';

  class ProfileScreen extends StatelessWidget {
    const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(36, 36, 36, 1),
              Color.fromRGBO(27, 27, 27, 1),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 55.0,
                    backgroundColor: secondaryColor,
                    child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7Q7EqY_tJt7qQ3h8VZGa4qQWDa063YysMw&s'),
                    ),
                  ),
                  
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                ],// children
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.star_border, color: Colors.white, size: 40.0),
                      Icon(Icons.star_border, color: primaryColor, size: 30.0),
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "ZONA PLG",
                        style: headingStyle.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        "ZONA PLG",
                        style: headingStyle,
                      ),
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.star_border, color: Colors.white, size: 40.0),
                      Icon(Icons.star_border, color: primaryColor, size: 30.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.hovered)) {
                      return backgroundColor2;
                    }
                    return backgroundColor;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.hovered)) {
                      return secondaryColor;
                    }
                    return primaryColor;
                  }),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text("ZONAPOLYGONGEN1@polygon.ac.th",
                  style: buttonStyle,
                ),
              ),
              SizedBox(height: 20.0),
              MenuProfile(
                iconData: Icons.home,
                title: 'Home',
              ),
              MenuProfile(
                iconData: Icons.person_2_rounded,
                title: 'Profile',
              ),
              MenuProfile(
                iconData: Icons.edit_square,
                title: 'Blogs',
              ),
              MenuProfile(
                iconData: Icons.settings,
                title: 'Setting',
              ),
              MenuProfile(
                iconData: Icons.info,
                title: 'Info',
              ),
              SignOutMenu(),
            ],
          ),
        ),
      ),
    );
  }
}