import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_gakgak/screens/bookmark_screen.dart';
import 'package:mobile_gakgak/screens/history_screen.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/user_service.dart';
import '../data/users.dart';

import 'package:mobile_gakgak/spare_recourse/bookmark_service.dart';
import 'package:mobile_gakgak/spare_recourse/history_service.dart';

class ProfileScreen extends StatefulWidget {
  final User userOBJ;

  const ProfileScreen({
    super.key,
    required this.userOBJ,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? userData;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = await UserService().getUser();
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        (userData?.name ?? "").isNotEmpty ? userData!.name : "Guest";

    final displayEmail =
        (userData?.email ?? "").isNotEmpty
            ? userData!.email
            : widget.userOBJ.email ?? "No Email";

    final profileImage =
        (userData?.profile ?? "").isNotEmpty
            ? userData!.profile
            : "pfp1.png";

    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // 🔥 Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("images/$profileImage"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    displayEmail,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ===============================
                  // 📌 BOOKMARK SECTION
                  // ===============================
                  _buildSectionTitle("Bookmark"),
                  const SizedBox(height: 15),
                  _buildGridSection(
                    type: "bookmark",
                    onMoreTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookmarkScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 35),

                  // ===============================
                  // 🕒 HISTORY SECTION
                  // ===============================
                  _buildSectionTitle("History"),
                  const SizedBox(height: 15),
                  _buildGridSection(
                    type: "history",
                    onMoreTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================
  // SECTION TITLE
  // ===============================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ===============================
  // 2x2 GRID SECTION
  // ===============================
  Widget _buildGridSection({
    required String type, // "bookmark" or "history"
    required VoidCallback onMoreTap,
  }) {
    final bookmarkService = BookmarkService();
    final historyService = HistoryService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<List<dynamic>>(
        stream: type == "bookmark"
            ? bookmarkService.streamBookmarks()
            : historyService.streamHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final items = snapshot.data!;

          // Take only first 3
          final previewItems = items.take(3).toList();

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              // 🔵 MORE TILE
              if (index == 3) {
                return GestureDetector(
                  onTap: onMoreTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(16),
                        child: Image.asset(
                          "images/more.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "More",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight:
                              FontWeight.bold,
                          foreground: Paint()
                            ..style =
                                PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.white,
                        ),
                      ),
                      const Text(
                        "More",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // If less than 3 items → empty tile
              if (index >= previewItems.length) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                );
              }

              final anime = previewItems[index];

              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(16),
                child: Image.network(
                  anime.picture,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}