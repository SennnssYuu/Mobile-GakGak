class AnimeBookmark {
  final String id;
  final String name;
  final String picture;
  final double rating;

  AnimeBookmark({
    required this.id,
    required this.name,
    required this.picture,
    required this.rating,
  });

  factory AnimeBookmark.fromMap(String id, Map<String, dynamic> map) {
    return AnimeBookmark(
      id: id,
      name: map['name'] ?? '',
      picture: map['picture'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture': picture,
      'rating': rating,
    };
  }
}