import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/bookmark_service.dart';
import '../data/anime_bookmark.dart';
import 'anime_detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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

          // 📚 Bookmark Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

                const Text(
                  "My Bookmarks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: FutureBuilder<List<AnimeBookmark>>(
                    future: BookmarkService().getBookmarks(),
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
                            "Failed to load bookmarks",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final bookmarks = snapshot.data ?? [];

                      if (bookmarks.isEmpty) {
                        return const Center(
                          child: Text(
                            "No bookmarks yet",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: bookmarks.length,
                        itemBuilder: (context, index) {
                          final anime = bookmarks[index];
                          return _buildBookmarkItem(context, anime);
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

  Widget _buildBookmarkItem(
      BuildContext context, AnimeBookmark anime) {
    final heroTag = "bookmark_${anime.id}";

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

          // 📄 Title + ⭐ Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      anime.rating.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
                    anime: {
                      'mal_id': anime.id,
                      'title': anime.name,
                      'score': anime.rating,
                      'images': {
                        'jpg': {
                          'large_image_url': anime.picture,
                          'image_url': anime.picture,
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