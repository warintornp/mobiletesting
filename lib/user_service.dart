// lib/pin_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String _apiUrl = 'http://localhost:3000/getUserDetails';

 Future<Map<String, dynamic>?> fetchUserDetails(String pin) async {
    final url = Uri.parse('$_apiUrl?pin=$pin'); // Append PIN as a query parameter
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Success
      return jsonDecode(response.body);
    } else {
      // Error
      return null;
    }
  }
}
