import 'package:flutter/material.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/repository/favorite_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  final _favoriteRepository = FavoriteRepository();

  ApiResponse<List<Favorites>> favoriteList = ApiResponse.initial();

  setFavorite(ApiResponse<List<Favorites>> response) {
    favoriteList = response;
    notifyListeners();
  }

  Future<void> getFavorite() async {
    setFavorite(ApiResponse.loading());
    await _favoriteRepository.getFavoriteOfProfileId().then((value) {
      setFavorite(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setFavorite(
          ApiResponse.error(error.toString()),
        ));
  }

  Future<void> updateFavorite({
    required bool statusFavorite,
    required String favoriteId,
  }) async {
    await _favoriteRepository
        .updateFavorite(statusFavorite: statusFavorite, favoriteId: favoriteId)
        .then((value) {
      setFavorite(
        ApiResponse.error(value),
      );
      getFavorite();
    }).onError((error, stackTrace) => setFavorite(
              ApiResponse.error(error.toString()),
            ));
  }
}
