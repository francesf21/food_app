import 'package:flutter/material.dart';

import 'package:food_app/models/models.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/models/produc_with_favorite.dart';
import 'package:food_app/repository/favorite_repository.dart';
import 'package:food_app/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final _homeRepository = HomeRepository();
  final _favoriteRepository = FavoriteRepository();

  ApiResponse<List<Categories>> categoriesList = ApiResponse.loading();
  ApiResponse<List<ProductWithFavorite>> productWithFavorite =
      ApiResponse.initial();

  setCategoriesList(ApiResponse<List<Categories>> response) {
    categoriesList = response;
    notifyListeners();
  }

  setProductWithFavoriteList(ApiResponse<List<ProductWithFavorite>> response) {
    productWithFavorite = response;
    notifyListeners();
  }

  Future<void> getCategoriesListApi() async {
    await _homeRepository.getCategories().then((value) {
      setCategoriesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setCategoriesList(
          ApiResponse.error(error.toString()),
        ));
  }

  Future<void> getProductWithFavoriteListApi(String categoryId) async {
    await _homeRepository
        .getProductWithFavorite(categoryId: categoryId)
        .then((value) {
      setProductWithFavoriteList(
        ApiResponse.completed(value),
      );
    }).onError((error, stackTrace) => setProductWithFavoriteList(
              ApiResponse.error(error.toString()),
            ));
  }

  Future<void> createOrInsertFavorite({
    required String CategoryId,
    required String? favoriteId,
    required String productId,
    required bool status,
  }) async =>
      favoriteId == null
          ? await _favoriteRepository
              .createFavorite(statusFavorite: status, productId: productId)
              .then((value) {
              setProductWithFavoriteList(ApiResponse.error(value));
              getProductWithFavoriteListApi(CategoryId);
            }).onError((error, stackTrace) => setProductWithFavoriteList(
                    ApiResponse.error(error.toString()),
                  ))
          : await _favoriteRepository
              .updateFavorite(statusFavorite: status, favoriteId: favoriteId)
              .then((value) {
              setProductWithFavoriteList(ApiResponse.error(value));
              getProductWithFavoriteListApi(CategoryId);
            }).onError((error, stackTrace) => setProductWithFavoriteList(
                    ApiResponse.error(error.toString()),
                  ));
}
