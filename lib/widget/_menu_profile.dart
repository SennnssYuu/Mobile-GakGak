import 'package:flutter/material.dart';
import '../constant/my_constant.dart';

class MenuProfile extends StatelessWidget {

  final IconData iconData;
  final String title;

  const MenuProfile({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
      
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0),
              Icon(iconData,
              color: headingStyle.color,
              size: 24.0),
              SizedBox(width: 10.0),
              Text(title, style: bodyStyle),
              Spacer(),
              Icon(Icons.arrow_forward_ios,
              color: headingStyle.color,
              size: 24.0),
              SizedBox(width: 10.0),
            ],
        ),
      ),
    );
  }
}

class SignOutMenu extends StatelessWidget {
  const SignOutMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 219, 218),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0),
              Icon(Icons.logout,
              color: Colors.red,
              size: 24.0),
              SizedBox(width: 10.0),
              Text("Sign out", style: bodyStyle.copyWith(color: Colors.red),),
            ],
        ),
      ),
    );
  }
}