import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:food_app/data/response/api_response.dart';
import 'package:food_app/repository/auth_repository.dart';

class LoginViewModel with ChangeNotifier {
  final _authRepository = AuthRepository();

  ApiResponse<AuthResponse> sessionUser = ApiResponse.initial();

  setInitSesion(ApiResponse<AuthResponse> response) {
    sessionUser = response;
    notifyListeners();
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    setInitSesion(ApiResponse.loading());
    _authRepository
        .singInWithPassword(email: email, password: password)
        .then((value) {
      setInitSesion(ApiResponse.completed(value));
    }).onError((error, _) => setInitSesion(
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
