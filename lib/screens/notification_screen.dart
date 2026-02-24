import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/setting_tiles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool NewAnimeisEnabled = false;
  bool ReccomendationisEnabled = false;
  bool SurveyisEnabled = false;
  bool AccountisEnabled = false;
  bool NewLoginisEnabled = false;


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
                  "Notification Settings",
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
                  icon: Icons.notifications,
                  title: "New Anime Releases",
                  description: "New anime releases and updates. \nEpisode and new season.",
                  trailing: Switch(
                    value: NewAnimeisEnabled,
                    onChanged: (value) {
                      setState(() {
                        NewAnimeisEnabled = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Recommendations",
                  description: "Recommendations based on your preferences",
                  trailing: Switch(
                    value: ReccomendationisEnabled,
                    onChanged: (value) {
                      setState(() {
                        ReccomendationisEnabled = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Surveys and Feedbacks",
                  description: "Participation and surveys.",
                  trailing: Switch(
                    value: SurveyisEnabled,
                    onChanged: (value) {
                      setState(() {
                        SurveyisEnabled = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SettingTile(
                  icon: Icons.notifications,
                  title: "Account Updates",
                  description: "Change password, icon, user name, etc.",
                  trailing: Switch(
                    value: AccountisEnabled,
                    onChanged: (value) {
                      setState(() {
                        AccountisEnabled = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SettingTile(
                  icon: Icons.notifications,
                  title: "New Login",
                  description: "New devices and instances.",
                  trailing: Switch(
                    value: NewLoginisEnabled,
                    onChanged: (value) {
                      setState(() {
                        NewLoginisEnabled = value;
                      });
                    },
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