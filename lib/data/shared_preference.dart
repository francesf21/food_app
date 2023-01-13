import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _instancia = SharedPreference._internal();

  static const String _token = "TOKEN";

  factory SharedPreference() {
    return _instancia;
  }

  SharedPreference._internal();

  late SharedPreferences _prefs;

  String get getTokenApp => _prefs.getString(_token) ?? '';

  set setTokenApp(String token) {
    _prefs.setString(_token, token);
  }

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
