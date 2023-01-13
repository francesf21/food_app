import 'package:flutter/material.dart';

import 'package:food_app/models/models.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<List<Categories>> categoriesList = ApiResponse.loading();
  ApiResponse<List<Products>> productsList = ApiResponse.loading();

  setCategoriesList(ApiResponse<List<Categories>> response) {
    categoriesList = response;
    notifyListeners();
  }

  setProductsList(ApiResponse<List<Products>> response) {
    productsList = response;
    notifyListeners();
  }

  Future<void> getCategoriesListApi() async {
    await _homeRepository.getCategories().then((value) {
      setCategoriesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setCategoriesList(
          ApiResponse.error(error.toString()),
        ));
  }

  Future<void> getProductOfCategoryIdListApi(String categoryId) async {
    await _homeRepository.getProductOfCategoryId(categoryId).then((value) {
      setProductsList(
        ApiResponse.completed(value),
      );
    }).onError((error, stackTrace) => setCategoriesList(
          ApiResponse.error(error.toString()),
        ));
  }
}
