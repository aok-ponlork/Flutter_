// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce/config/env.dart';

class CartHttpService {
  static Future<String?> addToCart(
      ProductData product, int quantity, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.apiURL}/api/cart/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
        body: jsonEncode({
          'product_id': product.id,
          'quantity': quantity,
        }),
      );
      if (response.statusCode == 200) {
        return 'success';
      } else if (response.statusCode == 401) {
        return 'unauthenticated';
      } else {
        print(response.statusCode);
        return 'failed';
      }
    } catch (e) {
      print('Error during addToCart: $e');
      return 'failed';
    }
  }

  static Future<List<CartData>?> fetchProductInCart(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.apiURL}/api/cart'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productInCart = Cart.fromJson(jsonData);
        if (productInCart.data != null) {
          return productInCart.data;
        } else {
          throw Exception('No products found in the response body.');
        }
      } else {
        throw Exception(
            'Failed to fetch products from the cart. Status Code: ${response.statusCode}, Response Body: ${response.body[0]}');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeFromCart(String id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppConfig.apiURL}/api/cart/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Success: 200-299 status codes
        return Future.value(true);
      } else {
        // Handle non-success status codes
        print('Failed to remove item from cart: ${response.statusCode}');
        print('${AppConfig.apiURL}/api/cart/$id');
        return true;
      }
    } catch (e) {
      // Handle exceptions
      print('Error removing item from cart: $e');
      // You might want to throw an exception or log the error for better debugging
      return false;
    }
  }
}
