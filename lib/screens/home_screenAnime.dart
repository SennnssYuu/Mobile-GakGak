import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import '../widget/appBackground.dart';
import 'anime_detail_screen.dart';

class TopSeasonAnimeScreen extends StatefulWidget {
  const TopSeasonAnimeScreen({super.key});

  @override
  State<TopSeasonAnimeScreen> createState() =>
      _TopSeasonAnimeScreenState();
}

class _TopSeasonAnimeScreenState
    extends State<TopSeasonAnimeScreen> {
  static Future<Map<String, dynamic>>? cachedAnimeData;
  late Future<Map<String, dynamic>> animeData;

  Future<List<dynamic>> fetchData(String url,
      {int limit = 5}) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> list = data['data'];

      list.removeWhere((anime) => anime['score'] == null);
      list.sort(
          (a, b) => b['score'].compareTo(a['score']));

      return list.take(limit).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Map<String, dynamic>> fetchAllData() async {
    final results = await Future.wait([
      fetchData("https://api.jikan.moe/v4/top/anime",
          limit: 5),
      fetchData("https://api.jikan.moe/v4/seasons/now",
          limit: 20),
      fetchData(
        "https://api.jikan.moe/v4/seasons/now?order_by=score&sort=desc",
        limit: 5,
      ),
    ]);

    return {
      "topAllTime": results[0],
      "newest": results[1],
      "seasonTop": results[2],
    };
  }

  @override
  void initState() {
    super.initState();
    cachedAnimeData ??= fetchAllData();
    animeData = cachedAnimeData!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child:
                FutureBuilder<Map<String, dynamic>>(
              future: animeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(
                            color: Colors.red),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Failed to load anime.",
                      style: TextStyle(
                          color: Colors.white),
                    ),
                  );
                }

                final topAllTime =
                    snapshot.data!["topAllTime"];
                final newest =
                    snapshot.data!["newest"];
                final seasonTop =
                    snapshot.data!["seasonTop"];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildCarousel(seasonTop),
                      const SizedBox(height: 30),
                      _buildSectionTitle(
                          "🏆 Top 5 Best of All Time"),
                      const SizedBox(height: 15),
                      _buildHorizontalList(
                          topAllTime),
                      const SizedBox(height: 30),
                      _buildSectionTitle(
                          "🆕 Newest Anime"),
                      const SizedBox(height: 15),
                      _buildGrid(newest),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildTopBar(context),
        ],
      ),
    );
  }

  // 🔥 CAROUSEL
  Widget _buildCarousel(List<dynamic> animeList) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 450,
        autoPlay: true,
        viewportFraction: 1.0,
      ),
      items: animeList.map((anime) {
        final heroTag =
            "season_${anime['mal_id']}";

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    AnimeDetailScreen(
                  anime: anime,
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Hero(
                tag: heroTag,
                child: Image.network(
                  anime['images']['jpg']
                      ['large_image_url'],
                  width: double.infinity,
                  height: 450,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 450,
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ],
                    begin:
                        Alignment.topCenter,
                    end: Alignment
                        .bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Spacer(),
                    Text(
                      anime['title'],
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 28,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    const SizedBox(
                        height: 8),
                    Text(
                      "⭐ ${anime['score']}",
                      style:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // 🔥 Horizontal List
  Widget _buildHorizontalList(
      List<dynamic> animeList) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal,
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime =
              animeList[index];
          final heroTag =
              "top_${anime['mal_id']}";

          return Container(
            width: 150,
            margin:
                const EdgeInsets.only(
                    left: 16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AnimeDetailScreen(
                          anime: anime,
                          heroTag:
                              heroTag,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: heroTag,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  8),
                      child:
                          Image.network(
                        anime['images']
                                ['jpg']
                            ['image_url'],
                        height: 180,
                        fit: BoxFit
                            .cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 8),
                Text(
                  anime['title'],
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                          color: Colors
                              .white),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${anime['score'] ?? 'N/A'}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔥 GRID
  Widget _buildGrid(
      List<dynamic> animeList) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),
        itemCount: animeList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemBuilder:
            (context, index) {
          final anime =
              animeList[index];
          final heroTag =
              "newest_${anime['mal_id']}";

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AnimeDetailScreen(
                    anime: anime,
                    heroTag:
                        heroTag,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius
                            .circular(
                                8),
                    child:
                        Image.network(
                      anime['images']
                              ['jpg']
                          ['image_url'],
                      height: 220,
                      fit:
                          BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 8),
                Text(
                  anime['title'],
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                          color: Colors
                              .white),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${anime['score'] ?? 'N/A'}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(
      String title) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              horizontal: 16),
      child: Text(
        title,
        style:
            const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}

Widget _buildTopBar(context) {
  return SafeArea(
    child: Padding(
      padding:
          const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon : Icon(Icons.search,
              color: Colors.white,
                            size: 28
            ),
            onPressed: () async{
              final result = await showSearch(
                context: context,
                delegate: AnimeSearchDelegate(),
              );

              if (result != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnimeDetailScreen(
                      anime: result,
                      heroTag: result['mal_id'].toString(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}

class AnimeSearchDelegate extends SearchDelegate {
  Future<List<dynamic>> fetchAnime(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(
      Uri.parse("https://api.jikan.moe/v4/anime?q=$query&limit=10"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception("Failed to load anime");
    }
  }

  @override
  String get searchFieldLabel => "Search anime...";

  // ❌ Clear button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }

  // 🔙 Back button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // 🔎 Results when submitted
  @override
  Widget buildResults(BuildContext context) {
    return Stack(
      children: [
        AppBackground(), // 👈 your background

        FutureBuilder<List<dynamic>>(
          future: fetchAnime(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final results = snapshot.data ?? [];

            if (results.isEmpty) {
              return const Center(
                child: Text(
                  "No results found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final anime = results[index];

                return ListTile(
                  leading: Image.network(
                    anime['images']['jpg']['image_url'],
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    anime['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "⭐ ${anime['score'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.white54),
                  ),
                  onTap: () {
                    close(context, anime);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  // 🔄 Suggestions while typing
  @override
  Widget buildSuggestions(BuildContext context) {
    return Stack(
      children: [
        AppBackground(),
        const Center(
          child: Text(
            "Search for your favorite anime...",
            style: TextStyle(color: Colors.white54),
          ),
        ),
      ],
    );
  }
}
