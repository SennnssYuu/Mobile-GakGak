import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_gakgak/screens/bookmark_screen.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import 'anime_detail_screen.dart';
import 'history_screen.dart';


class ProfileScreen extends StatefulWidget {
  final User userOBJ;
  final String user;

  const ProfileScreen({
    super.key,
    required this.userOBJ,
    required this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static Future<List<dynamic>>? cachedTopAnime;
  late Future<List<dynamic>> topAnime;

  Future<List<dynamic>> fetchTopAnime() async {
    final response =
        await http.get(Uri.parse("https://api.jikan.moe/v4/top/anime?limit=5"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception("Failed to load anime");
    }
  }

  @override
  void initState() {
    super.initState();

    cachedTopAnime ??= fetchTopAnime();
    topAnime = cachedTopAnime!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: FutureBuilder<List<dynamic>>(
              future: topAnime,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }

                final animeList = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // 🔥 Avatar Section
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7Q7EqY_tJt7qQ3h8VZGa4qQWDa063YysMw&s',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {}, // Empty for now
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
                          )
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text(
                        widget.user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        widget.userOBJ.email ?? "",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 👀 TO WATCH LIST
                      _buildSectionTitle("My To-Watch List"),
                      const SizedBox(height: 15),
                      _buildAnimeRow(animeList, "To-Watch"),

                      const SizedBox(height: 30),

                      // 📺 HISTORY LIST
                      _buildSectionTitle("My History Watched"),
                      const SizedBox(height: 15),
                      _buildAnimeRow(animeList, "History"),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
        ),
      ),
        ],
      )
      
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buildAnimeRow(List<dynamic> animeList, String section) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        if (index == 3) {
          return _buildMoreBox(context, section);
        }

        final anime = animeList[index];
        final heroTag = "${anime['mal_id']}_${section}_$index";

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AnimeDetailScreen(
                  anime: anime,
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                anime['images']['jpg']['image_url'],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildMoreBox(BuildContext context, String section) {
    return GestureDetector(
      onTap: () {
        if (section == "History") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HistoryScreen(),
            ),
          );
        } else if (section == "To-Watch") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookmarkScreen(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            "More",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

}