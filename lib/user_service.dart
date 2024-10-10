import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>> fetchUserDetails() async {
    final url = Uri.parse('http://localhost:3000/v1/api/user');
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');

    if (authToken == null) {
      return {};
    }

    try {
      final response = await http.get(
        url,
        headers: {
          "content-type": "application/json",
          'Authorization': authToken,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
