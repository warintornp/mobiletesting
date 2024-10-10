import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<bool> authenticate(String pin) async {
    final url = Uri.parse('http://localhost:3000/v1/api/pin/validate');
    final body = jsonEncode({'pin': pin});

    try {
      final response = await http
          .post(url, body: body, headers: {"content-type": "application/json"});

      if (response.statusCode == 200) {
        final authToken = response.headers['authorization'];
        if (authToken != null) {
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

  // Future<Map<String, dynamic>?> getUserDetail(String pin) async {
  //   final url = Uri.parse('http://localhost:3000/v1/api/pin/validate');
  //   final body = jsonEncode({'pin': pin});

  //   try {
  //     final response = await http
  //         .post(url, body: body, headers: {"content-type": "application/json"});

  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     } else {
  //       // print('Failed to fetch user details: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     // print('Failed to fetch user details: $e');
  //     return null;
  //   }
  // }
}
