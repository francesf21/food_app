import 'package:food_app/data/config.dart';
import 'package:food_app/data/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  Future<bool> redirect() async {
    try {
      return supabase.auth.currentSession != null;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> singInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      prefs.setTokenApp = response.session!.accessToken;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      prefs.setTokenApp = response.session!.accessToken;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (error) {
      print("Error en el metodo forgotPassword $error");
    } catch (e) {
      print("Error en el metodo forgotPassword $e");
    }
  }
}
