import 'dart:convert';

import 'package:food_app/data/supabase/supabase.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/produc_with_favorite.dart';
import 'package:food_app/res/res.dart';
import 'package:food_app/data/network/network_api_services.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Categories>> getCategories() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrl.categoriesList,
      );
      return response = categoriesFromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductWithFavorite>> getProductWithFavorite({
    required String categoryId,
  }) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = {"p_category_id": categoryId, "p_profile_id": userId};

      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.productWithFavorite,
        json.encode(data),
      );
      return response = productWithFavoriteFromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
