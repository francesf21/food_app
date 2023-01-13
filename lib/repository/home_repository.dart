import 'package:food_app/models/models.dart';
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

  Future<List<Products>> getProductOfCategoryId(String categoryId) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        "${AppUrl.productOfCategoryId}$categoryId",
      );
      return response = productsFromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
