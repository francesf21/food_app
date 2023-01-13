import 'dart:convert';

List<Products> productsFromMap(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromMap(x)));

class Products {
  final String id;
  final String categoryId;
  final String name;
  final double price;
  final String image;
  final String descripction;
  final String status;
  final DateTime createdAt;

  Products({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.image,
    required this.descripction,
    required this.status,
    required this.createdAt,
  });

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        descripction: json["descripction"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
