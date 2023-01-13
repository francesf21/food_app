import 'package:flutter/material.dart';
import 'package:food_app/repository/auth_repository.dart';

class ForgotViewModel with ChangeNotifier {
  final _authRepository = AuthRepository();

  void forgotPassword({required String email}) async {
    try {
      await _authRepository
          .forgotPassword(email: email)
          .then((value) => null)
          .onError((error, stackTrace) => null);
    } catch (e) {
      print("Error en el ForgotViewModel $e");
    }
  }
}
