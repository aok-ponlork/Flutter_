// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_commerce/config/env.dart';
import 'package:e_commerce/models/order_detail_model.dart'; // Assuming OrderDetail class is imported correctly
import 'package:http/http.dart' as http;

class OrderDetailService {
  static Future<List<OrderDetail>?> fetchOrderData(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.apiURL}/api/order-detail/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<OrderDetail> orderDataList =
            jsonData.map((item) => OrderDetail.fromJson(item)).toList();
        print(orderDataList);
        return orderDataList;
      } else {
        print(response.statusCode);
        throw Exception(
            'Failed to fetch order details. Status Code: ${response.statusCode}, Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
