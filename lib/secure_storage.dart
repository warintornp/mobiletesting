import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static SharedPreferences? sharedPreferences;
  // this function possible to throw an exception
  Future<void> store(String key, String value) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // this function possible to throw an exception
  Future<String?> retrieve(String key) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
