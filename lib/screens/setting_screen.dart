import 'package:flutter/material.dart';
import '../widget/appBackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin_screen.dart'; // adjust path if needed


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const AppBackground(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // 🔥 Title
                const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: ListView(
                    children: [
                      _buildSettingItem(
                        icon: Icons.person_outline,
                        title: "Account",
                        onTap: () {},
                      ),
                      _buildSettingItem(
                        icon: Icons.notifications_none,
                        title: "Notifications",
                        onTap: () {},
                      ),
                      _buildSettingItem(
                        icon: Icons.lock_outline,
                        title: "Privacy & Security",
                        onTap: () {},
                      ),
                      _buildSettingItem(
                        icon: Icons.help_outline,
                        title: "Help & Support",
                        onTap: () {},
                      ),
                      _buildSettingItem(
                        icon: Icons.logout,
                        title: "Sign Out",
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        isSignOut: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSignOut = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white12),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSignOut ? Colors.red : Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSignOut ? Colors.red : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
