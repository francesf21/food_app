import 'dart:convert';

import 'package:food_app/data/network/network_api_services.dart';
import 'package:food_app/data/supabase/supabase.dart';
import 'package:food_app/models/produc_with_favorite.dart';
import 'package:food_app/res/res.dart';

class SearchRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<ProductWithFavorite>> getSearchProducts(String value) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = {"namesearch": value, "p_profile_id": userId};

      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.searchFood,
        json.encode(data),
      );
      return response = productWithFavoriteFromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
