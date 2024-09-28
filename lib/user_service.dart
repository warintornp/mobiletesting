import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String _apiUrl = 'http://localhost:3000/getUserDetails'; // Replace with your server URL

  Future<Map<String, dynamic>?> fetchUserDetails(String pin) async {
    final url = Uri.parse('$_apiUrl?pin=$pin'); // Use GET request with query parameters
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // print('Failed to fetch user details: ${response.statusCode}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails2(String pin) async {
    final url = Uri.parse('http://localhost:3000/v1/api/pin/validate');
    final body = jsonEncode({'pin': pin});

    try {
      final response = await http
          .post(url, body: body, headers: {"content-type": "application/json"});

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // print('Failed to fetch user details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // print('Failed to fetch user details: $e');
      return null;
    }
  }
}
