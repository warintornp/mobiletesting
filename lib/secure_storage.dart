import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  Future<void> store(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
