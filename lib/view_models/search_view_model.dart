import 'package:flutter/material.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/models/produc_with_favorite.dart';
import 'package:food_app/repository/favorite_repository.dart';
import 'package:food_app/repository/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final _searchRepository = SearchRepository();
  final _favoriteRepository = FavoriteRepository();

  ApiResponse<List<ProductWithFavorite>> searchProductList =
      ApiResponse.initial();

  setSearchProductList(ApiResponse<List<ProductWithFavorite>> response) {
    searchProductList = response;
    notifyListeners();
  }

  Future<void> getSearchProductList(String value) async {
    await _searchRepository.getSearchProducts(value).then((value) {
      setSearchProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setSearchProductList(
          ApiResponse.error(error.toString()),
        ));
  }

  Future<void> createOrUpdateFavorite({
    required String valueSearch,
    required String? favoriteId,
    required String productId,
    required bool status,
  }) async =>
      favoriteId == null
          ? await _favoriteRepository
              .createFavorite(statusFavorite: status, productId: productId)
              .then((value) {
              setSearchProductList(ApiResponse.error(value));
              getSearchProductList(valueSearch);
            }).onError((error, stackTrace) => setSearchProductList(
                    ApiResponse.error(error.toString()),
                  ))
          : await _favoriteRepository
              .updateFavorite(statusFavorite: status, favoriteId: favoriteId)
              .then((value) {
              setSearchProductList(ApiResponse.error(value));
              getSearchProductList(valueSearch);
            }).onError((error, stackTrace) => setSearchProductList(
                    ApiResponse.error(error.toString()),
                  ));
}
