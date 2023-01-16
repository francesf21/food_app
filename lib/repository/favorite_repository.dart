import 'dart:convert';

import 'package:food_app/data/network/network_api_services.dart';
import 'package:food_app/data/supabase/supabase.dart';
import 'package:food_app/models/favorites.dart';
import 'package:food_app/res/res.dart';

class FavoriteRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Favorites>> getFavoriteOfProfileId() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      dynamic response = await _apiServices.getGetApiResponse(
        "${AppUrl.favoriteForProfileId}$userId",
      );
      return response = favoritesFromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createFavorite({
    required bool statusFavorite,
    required String productId,
  }) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = {
        "status": statusFavorite,
        "profile_id": userId,
        "product_id": productId,
      };
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.favoriteCreate,
        json.encode(data),
      );
      return response = response.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateFavorite({
    required bool statusFavorite,
    required String favoriteId,
  }) async {
    try {
      final data = {
        "status": statusFavorite,
      };
      dynamic response = await _apiServices.getPatchApiResponse(
        "${AppUrl.favoriteUpdate}$favoriteId",
        json.encode(data),
      );
      return response = response.toString();
    } catch (e) {
      rethrow;
    }
  }
}
