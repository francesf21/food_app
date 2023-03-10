import 'package:food_app/data/config.dart';
import 'package:food_app/data/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  Future<bool> redirect() async {
    try {
      prefs.setTokenApp = supabase.auth.currentSession?.accessToken ?? "";
      return supabase.auth.currentSession != null;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> singInWithPassword({
    required String email,
    required String password,
  }) async =>
      await supabase.auth
          .signInWithPassword(email: email, password: password)
          .then((value) {
        prefs.setTokenApp = value.session!.accessToken;
        return value;
      });

  Future<AuthResponse> signUpUser({
    required String email,
    required String password,
  }) async =>
      await supabase.auth.signUp(email: email, password: password).then(
        (value) {
          prefs.setTokenApp = value.session!.accessToken;
          return value;
        },
      );

  Future<void> forgotPassword({
    required String email,
  }) async =>
      await supabase.auth.resetPasswordForEmail(
        email,
      );

  Future<void> signOut() async => await supabase.auth.signOut().then(
        (_) => prefs.setTokenApp = "",
      );
}
