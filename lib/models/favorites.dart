import 'dart:convert';

List<Favorites> favoritesFromMap(String str) =>
    List<Favorites>.from(json.decode(str).map((x) => Favorites.fromMap(x)));

class Favorites {
  Favorites({
    required this.favoriteId,
    required this.name,
    required this.image,
    required this.price,
    required this.status,
    required this.productId,
    required this.profileId,
  });

  final String favoriteId;
  final String name;
  final String image;
  final double price;
  final bool status;
  final String productId;
  final String profileId;

  factory Favorites.fromMap(Map<String, dynamic> json) => Favorites(
        favoriteId: json["favorite_id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        status: json["status"],
        productId: json["product_id"],
        profileId: json["profile_id"],
      );
}
