import 'package:flutter/material.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';
import '../spare_recourse/bookmark_service.dart';
import '../data/anime_bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'stream_screen.dart';
import '../spare_recourse/history_service.dart';
import '../data/anime_history.dart';

class AnimeDetailScreen extends StatefulWidget {
  final dynamic anime;
  final String heroTag;

  const AnimeDetailScreen({
    super.key,
    required this.anime,
    required this.heroTag,
  });

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _checkIfBookmarked() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final animeId = widget.anime['mal_id'].toString();

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(animeId)
        .get();

    setState(() {
      isBookmarked = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppBackground(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 HERO IMAGE
                Hero(
                  tag: widget.heroTag,
                  child: Image.network(
                    widget.anime['images']['jpg']['large_image_url'],
                    width: double.infinity,
                    height: 650,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 🔥 TITLE
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.anime['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // 🔖 BOOKMARK + ▶ WATCH BUTTONS
                          Wrap(
                            spacing: 8,
                            children: [
                              // 🔖 Bookmark Button
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  ),
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (isBookmarked) {
                                      await _removeBookmark();
                                    } else {
                                      await _addBookmark();
                                    }
                                  },
                                ),
                              ),

                              // ▶ Watch Button
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final historyService = HistoryService();
                                    final anime = widget.anime;

                                    final historyItem = AnimeHistory(
                                      id: anime['mal_id'].toString(),
                                      name: anime['title'] ?? '',
                                      picture: anime['images']['jpg']['large_image_url'] ?? '',
                                      rating: (anime['score'] ?? 0).toDouble(),
                                      watchedAt: DateTime.now(),
                                    );

                                    await historyService.addToHistory(historyItem);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const VideoScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Watch",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ⭐ STAR RATING
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${widget.anime['score'] ?? 'N/A'}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 📖 SYNOPSIS (optional but nice)
                      if (widget.anime['synopsis'] != null)
                        Text(
                          widget.anime['synopsis'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔙 BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
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
        ],
      ),
    );
  }
  Future<void> _addBookmark() async {
    final anime = widget.anime;

    final bookmark = AnimeBookmark(
      id: anime['mal_id'].toString(),
      name: anime['title'] ?? '',
      picture: anime['images']['jpg']['large_image_url'] ?? '',
      rating: (anime['score'] ?? 0).toDouble(),
    );

    await BookmarkService().addBookmark(bookmark);

    setState(() {
      isBookmarked = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to bookmarks")),
    );
  }

  Future<void> _removeBookmark() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final animeId = widget.anime['mal_id'].toString();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('bookmarks')
      .doc(animeId)
      .delete();

  setState(() {
    isBookmarked = false;
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Removed from bookmarks")),
  );
}
}
