import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/config/env.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/order_detail_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final TokenController _tokenController = Get.find<TokenController>();
  static final CartController _cartController = Get.put(CartController());
  static final UserController _userController = Get.put(UserController());
  static final OrderDetailController _orderDetailController =
      Get.put(OrderDetailController());
  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.apiURL}/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        final String token = responseBody['data']['token'];
        _tokenController.updateToken(token);
        _cartController.fetchProductInCart();
        _userController.fetchUserInfo();
        _orderDetailController.fetchOrderData();
        return null; // No error message, login successful
      } else {
        // Return the error message
        return 'Login failed: ${responseBody['message']}';
      }
    } catch (e) {
      // Check if the error is due to network issues or server unavailability
      if (e is SocketException) {
        return 'Error connecting to the server. Please check your internet connection.';
      } else {
        // Return the exception message
        return 'An unexpected error occurred: $e';
      }
    }
  }

  static Future<bool> logout() async {
    try {
      final token = _tokenController.token.value;
      if (token.isEmpty) {
        return false;
      }
      final response = await http.post(
        Uri.parse('${AppConfig.apiURL}/api/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );
      if (response.statusCode == 200) {
        _tokenController.clearToken();
        _cartController.clearCart();
        Get.toNamed('/login');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String?> register(
      String userName, String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse('${AppConfig.apiURL}/api/register'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {'email': email, 'password': password, 'name': userName}));
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        final String token = responseBody['data']['token'];
        _tokenController.updateToken(token);
        _cartController.clearCart();
        _userController.fetchUserInfo();
        return 'Register success!';
      } else {
        return 'Register failed: ${responseBody['message']}';
      }
    } catch (e) {
      return 'Register failed: An unexpected error occurred: $e';
    }
  }
}
