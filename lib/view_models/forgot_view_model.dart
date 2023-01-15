import 'package:flutter/material.dart';
import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotViewModel with ChangeNotifier {
  final _authRepository = AuthRepository();

  ApiResponse<bool> emailUser = ApiResponse.initial();

  setInitSesion(ApiResponse<bool> response) {
    emailUser = response;
    notifyListeners();
  }

  Future<void> sendEmail({
    required String email,
  }) async {
    setInitSesion(ApiResponse.loading());
    _authRepository.forgotPassword(email: email).then((value) {
      setInitSesion(ApiResponse.completed(true));
    }).onError((error, stackTrace) => setInitSesion(
          ApiResponse.error(returnResponse(error as AuthException)),
        ));
  }

  dynamic returnResponse(AuthException response) {
    switch (response.statusCode) {
      case "400":
        return "Error, Usuario y/o contraseña incorrecto";
      case "404":
        return "Usuario ya registrado, por favor inicie sesión";
      case "500":
        return "Usuario ya registrado, por favor inicie sesión";
      default:
        return "Error en la comunicación, intente más tarde";
    }
  }
}
