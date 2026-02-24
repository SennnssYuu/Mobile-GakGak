import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/setting_tiles.dart';
import '../spare_recourse/user_service.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  bool TwoFactorAuthisEnabled = false;
  bool thirdPartyCookiesisEnabled = false;
  bool adultContentFilterisEnabled = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final data = await UserService().getSettings();

    setState(() {
      TwoFactorAuthisEnabled = data['TwoFactorAuthisEnabled'] ?? false;
      thirdPartyCookiesisEnabled = data['thirdPartyCookiesisEnabled'] ?? false;
      adultContentFilterisEnabled = data['adultContentFilterisEnabled'] ?? false;
      isLoading = false;
    });
  }

  Future<void> _update(String field, bool value) async {
    setState(() {
      switch (field) {
        case 'TwoFactorAuthisEnabled':
          TwoFactorAuthisEnabled = value;
          break;
        case 'thirdPartyCookiesisEnabled':
          thirdPartyCookiesisEnabled = value;
          break;
        case 'adultContentFilterisEnabled':
          adultContentFilterisEnabled = value;
          break;
      }
    });

    await UserService().updateSetting(field, value);
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                  "Privacy Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SettingTile(
                  icon: Icons.security,
                  title: "Two-Factor Authentication",
                  description:
                      "Add an extra layer of security to your account.",
                  trailing: Switch(
                    value: TwoFactorAuthisEnabled,
                    onChanged: (value) =>
                        _update('TwoFactorAuthisEnabled', value),
                  ),
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.cookie,
                  title: "Third-Party Cookies",
                  description:
                      "Allow third-party cookies to be set by external websites.",
                  trailing: Switch(
                    value: thirdPartyCookiesisEnabled,
                    onChanged: (value) =>
                        _update('thirdPartyCookiesisEnabled', value),
                  ),
                ),

                const SizedBox(height: 5),

                SettingTile(
                  icon: Icons.visibility_off,
                  title: "Adult Content Filter",
                  description:
                      "Filter explicit content from search results.",
                  trailing: Switch(
                    value: adultContentFilterisEnabled,
                    onChanged: (value) =>
                        _update('adultContentFilterisEnabled', value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}