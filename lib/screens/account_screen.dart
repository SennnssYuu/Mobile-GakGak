import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/setting_tiles.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // bool GenderisEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 25),

                const Text(
                  "Account Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: const [
                    SizedBox(width: 20),
                    Expanded(child: Divider()),
                    SizedBox(width: 20),
                  ],
                ),

                const SizedBox(height: 10),

                SettingTile(
                  icon: Icons.add_a_photo,
                  title: "Change Profile Picture",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.edit,
                  title: "Change Username",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.person_outline,
                  title: "Change Gender",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.phone_android_outlined,
                  title: "Change Phone number",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.cake_outlined,
                  title: "Change Birthday",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}