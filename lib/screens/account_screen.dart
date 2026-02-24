import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/setting_tiles.dart';
import '../spare_recourse/user_service.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

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

                const SizedBox(height: 20),

                SettingTile(
                  icon: Icons.add_a_photo,
                  title: "Change Profile Picture",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: _showProfilePicker,
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.edit,
                  title: "Change Username",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {
                    _showEditDialog(
                      title: "Username",
                      field: "name",
                    );
                  },
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.email_outlined,
                  title: "Change Email",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {
                    _showEditDialog(
                      title: "Email",
                      field: "email",
                    );
                  },
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.person_outline,
                  title: "Change Gender",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {
                    _showEditDialog(
                      title: "Gender",
                      field: "gender",
                    );
                  },
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.phone_android_outlined,
                  title: "Change Phone number",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {
                    _showEditDialog(
                      title: "Phone Number",
                      field: "phone",
                    );
                  },
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.cake_outlined,
                  title: "Change Birthday",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {
                    _showEditDialog(
                      title: "Birthday",
                      field: "birthday",
                    );
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog({
    required String title,
    required String field,
  }) async {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new $title",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final value = controller.text.trim();

              if (value.isEmpty) return;

              await UserService().updateField(field, value);

              if (!context.mounted) return;

              Navigator.pop(context); // close edit dialog

              _showSuccessDialog(title);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String fieldName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text("Update Successful"),
          ],
        ),
        content: Text("$fieldName updated successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _showProfilePicker() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Profile Picture"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _profileOption("pfp1.png"),
            _profileOption("pfp2.png"),
            _profileOption("pfp3.png"),
          ],
        ),
      ),
    );
  }

  Widget _profileOption(String imageName) {
    return GestureDetector(
      onTap: () async {
        await UserService().updateField("profil", imageName);

        if (!context.mounted) return;

        Navigator.pop(context); // close dialog

        _showSuccessDialog("Profile Picture");
      },
      child: CircleAvatar(
        radius: 35,
        backgroundImage:
            AssetImage("images/$imageName"),
      ),
    );
  }
}