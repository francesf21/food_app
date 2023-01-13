import 'package:flutter/material.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/repository/auth_repository.dart';

class SplashViewModel with ChangeNotifier {
  final _authRepository = AuthRepository();

  ApiResponse<bool> statusSplash = ApiResponse.initial();

  setStatusSplash(ApiResponse<bool> response) {
    statusSplash = response;
    Future.delayed(const Duration(seconds: 2), () {
      notifyListeners();
    });
  }

  Future<void> initSplash() async {
    setStatusSplash(ApiResponse.loading());
    await _authRepository.redirect().then((value) {
      setStatusSplash(ApiResponse.completed(value));
    }).onError((error, stackTrace) => setStatusSplash(
          ApiResponse.error(error.toString()),
        ));
  }
}
