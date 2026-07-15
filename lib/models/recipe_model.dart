class Recipe {
  final int id;
  final String name;
  final String image;
  final String cuisine;
  final String difficulty;
  final int cookTimeMinutes;
  final double rating;
  final int reviewCount;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.difficulty,
    required this.cookTimeMinutes,
    required this.rating,
    required this.reviewCount,
  });

  // details tp fetch from the api
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      cuisine: json['cuisine'] ?? '',
      difficulty: json['difficulty'] ?? '',
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      rating: (json['rating'] is int) ? (json['rating'] as int).toDouble() : (json['rating'] ?? 0.0),
      reviewCount: json['reviewCount'] ?? 0,
    );
  }
}