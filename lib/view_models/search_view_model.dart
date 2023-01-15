import 'package:flutter/material.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/repository/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final _searchRepository = SearchRepository();

  ApiResponse<List<Products>> searchProductList = ApiResponse.initial();

  setSearchProductList(ApiResponse<List<Products>> response) {
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
}
