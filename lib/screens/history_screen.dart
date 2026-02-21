import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_gakgak/widget/appBackground.dart';
import 'anime_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<List<dynamic>> fetchHistoryAnime() async {
    final response = await http.get(
      Uri.parse("https://api.jikan.moe/v4/top/anime?limit=10"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception("Failed to load anime");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppBackground(),
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
                const SizedBox(height: 16),

                const Text(
                  "Watch History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchHistoryAnime(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "Failed to load history",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final animeList = snapshot.data ?? [];

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: animeList.length,
                        itemBuilder: (context, index) {
                          final anime = animeList[index];

                          return _buildHistoryItem(context, anime, index);
                        },
                      );
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

  Widget _buildHistoryItem(
      BuildContext context, dynamic anime, int index) {
    // Fake last watched episode (for now)
    final fakeEpisode = "19/20/2006";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 🎞 Anime Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              anime['images']['jpg']['image_url'],
              width: 80,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 16),

          // 📄 Title + Last Watched
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Last watched: $fakeEpisode",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // ➡ Arrow Button
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 18,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AnimeDetailScreen(
                    anime: anime,
                    heroTag: "history_${anime['mal_id']}",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}