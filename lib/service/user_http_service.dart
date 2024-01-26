// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:e_commerce/config/env.dart';
import 'package:http/http.dart' as http;

class UserHttpService {
  static Future<Map<String, dynamic>?> getUserInfo(String token) async {
    final Uri uri = Uri.parse('${AppConfig.apiURL}/api/user-profile');
    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      });
      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load user info: $e');
    }
  }
}
