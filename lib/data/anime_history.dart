import 'package:cloud_firestore/cloud_firestore.dart';

class AnimeHistory {
  final String id;
  final String name;
  final String picture;
  final double rating;
  final DateTime watchedAt;

  AnimeHistory({
    required this.id,
    required this.name,
    required this.picture,
    required this.rating,
    required this.watchedAt,
  });

  factory AnimeHistory.fromMap(
      String id, Map<String, dynamic> map) {
    return AnimeHistory(
      id: id,
      name: map['name'] ?? '',
      picture: map['picture'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      watchedAt:
          (map['watchedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture': picture,
      'rating': rating,
      'watchedAt': Timestamp.fromDate(watchedAt),
    };
  }
}