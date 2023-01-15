import 'package:food_app/data/network/network_api_services.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/res/res.dart';

class SearchRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Products>> getSearchProducts(String value) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        "${AppUrl.searchFood}*$value*",
      );
      return response = productsFromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
