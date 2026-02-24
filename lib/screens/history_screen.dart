import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/history_service.dart';
import '../data/anime_history.dart';
import 'anime_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const AppBackground(),

          // 🔙 Back Button
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

          // 🕒 History Content
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
                  child: FutureBuilder<List<AnimeHistory>>(
                    future: HistoryService().getHistory(),
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

                      final historyList = snapshot.data ?? [];

                      if (historyList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No watch history yet",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: historyList.length,
                        itemBuilder: (context, index) {
                          final anime = historyList[index];
                          return _buildHistoryItem(context, anime);
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
      BuildContext context, AnimeHistory anime) {
    final heroTag = "history_${anime.id}";

    final formattedDate =
        DateFormat('dd MMM yyyy - HH:mm')
            .format(anime.watchedAt);

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
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                anime.picture,
                width: 80,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 📄 Title + Last Watched Time
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  anime.name,
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
                  "Last watched: $formattedDate",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // ➡ Arrow
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
                    anime: {
                      'mal_id': anime.id,
                      'title': anime.name,
                      'score': anime.rating,
                      'images': {
                        'jpg': {
                          'large_image_url':
                              anime.picture,
                          'image_url':
                              anime.picture,
                        }
                      },
                    },
                    heroTag: heroTag,
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