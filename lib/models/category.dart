import 'dart:convert';

List<Categories> categoriesFromMap(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromMap(x)));

class Categories {
  final String id;
  final String nameCategory;
  final String statusCategory;
  final DateTime createdAt;

  Categories({
    required this.id,
    required this.nameCategory,
    required this.statusCategory,
    required this.createdAt,
  });

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        nameCategory: json["name_category"],
        statusCategory: json["status_category"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
