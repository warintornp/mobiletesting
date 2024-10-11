import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final http.Client client;

  LoginService({http.Client? client}) : client = client ?? http.Client();

  Future<bool> authenticate(String pin) async {
    final url = Uri.parse('http://localhost:3000/v1/api/pin/validate');
    final body = jsonEncode({'pin': pin});

    try {
      final response = await client
          .post(url, body: body, headers: {"content-type": "application/json"});

      if (response.statusCode == 200) {
        final authToken = response.headers['authorization'];
        if (authToken != null && authToken != '') {
          //business accept risk to not check authToken format
          await _storeAuthToken(authToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _storeAuthToken(String token) async {
    // Store the token securely
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }
}
