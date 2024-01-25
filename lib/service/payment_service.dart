// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:e_commerce/config/env.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static final TokenController _tokenController = Get.find<TokenController>();

  static Future<http.Response> requestPayment(
      bool isFastBuy, double amount, String product_id) async {
    const apiUrl = '${AppConfig.apiURL}/api/charge/';
    try {
      final String token = _tokenController.token.value;
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
          },
          body: jsonEncode({
            'amount': amount.toString(),
            'is_fast_buy': isFastBuy,
            'product_id': product_id
          }));
      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
