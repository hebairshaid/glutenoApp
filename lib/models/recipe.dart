import 'dart:convert';

class Recipe {
  final int id;
  final String title;
  final String content;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  static List<Recipe> listFromJson(String jsonString) {
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded
        .map((item) => Recipe.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
