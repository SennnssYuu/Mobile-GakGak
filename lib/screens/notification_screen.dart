import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/setting_tiles.dart';
import '../spare_recourse/user_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  bool AccountisEnabled = false;
  bool NewAnimeisEnabled = false;
  bool NewLoginisEnabled = false;
  bool ReccomendationisEnabled = false;
  bool SurveyisEnabled = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final data = await UserService().getSettings();

    setState(() {
      AccountisEnabled = data['AccountisEnabled'] ?? false;
      NewAnimeisEnabled = data['NewAnimeisEnabled'] ?? false;
      NewLoginisEnabled = data['NewLoginisEnabled'] ?? false;
      ReccomendationisEnabled = data['ReccomendationisEnabled'] ?? false;
      SurveyisEnabled = data['SurveyisEnabled'] ?? false;
      isLoading = false;
    });
  }

  Future<void> _update(String field, bool value) async {
    setState(() {
      switch (field) {
        case 'AccountisEnabled':
          AccountisEnabled = value;
          break;
        case 'NewAnimeisEnabled':
          NewAnimeisEnabled = value;
          break;
        case 'NewLoginisEnabled':
          NewLoginisEnabled = value;
          break;
        case 'ReccomendationisEnabled':
          ReccomendationisEnabled = value;
          break;
        case 'SurveyisEnabled':
          SurveyisEnabled = value;
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
                  "Notification Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SettingTile(
                  icon: Icons.notifications,
                  title: "New Anime Releases",
                  description:
                      "Get notified when new anime are released.",
                  trailing: Switch(
                    value: NewAnimeisEnabled,
                    onChanged: (value) =>
                        _update('NewAnimeisEnabled', value),
                  ),
                ),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Recommendations",
                  description:
                      "Recommendations based on your pre-watched anime.",
                  trailing: Switch(
                    value: ReccomendationisEnabled,
                    onChanged: (value) =>
                        _update('ReccomendationisEnabled', value),
                  ),
                ),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Surveys and Feedbacks",
                  description:
                      "Participate in surveys and provide feedbacks.",
                  trailing: Switch(
                    value: SurveyisEnabled,
                    onChanged: (value) =>
                        _update('SurveyisEnabled', value),
                  ),
                ),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Account Updates",
                  description:
                      "Change account detail, username, etc.",
                  trailing: Switch(
                    value: AccountisEnabled,
                    onChanged: (value) =>
                        _update('AccountisEnabled', value),
                  ),
                ),

                SettingTile(
                  icon: Icons.notifications,
                  title: "New Login",
                  description:
                      "Get notified when a new login is detected.",
                  trailing: Switch(
                    value: NewLoginisEnabled,
                    onChanged: (value) =>
                        _update('NewLoginisEnabled', value),
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