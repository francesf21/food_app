import 'dart:convert';

List<ProductWithFavorite> productWithFavoriteFromMap(String str) =>
    List<ProductWithFavorite>.from(
      json.decode(str).map((x) => ProductWithFavorite.fromMap(x)),
    );

class ProductWithFavorite {
  ProductWithFavorite({
    required this.favoriteId,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.descripction,
    required this.price,
    required this.status,
    required this.productId,
    required this.profileId,
  });

  final String favoriteId;
  final String categoryId;
  final String name;
  final String image;
  final String descripction;
  final double price;
  final bool status;
  final String productId;
  final String profileId;

  factory ProductWithFavorite.fromMap(Map<String, dynamic> json) =>
      ProductWithFavorite(
        favoriteId: json["favorite_id"],
        categoryId: json["category_id"],
        name: json["name"],
        image: json["image"],
        descripction: json["descripction"],
        price: json["price"],
        status: json["status"],
        productId: json["product_id"],
        profileId: json["profile_id"],
      );
}
