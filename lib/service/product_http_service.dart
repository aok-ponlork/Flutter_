// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:e_commerce/config/env.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/single_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class HttpService {
  static String? authToken() {
    final box = GetStorage();
    return box.read<String>('authToken');
  }

  /// Fetches a list of products from the API.
  /// Returns a Future<List<ProductData>>.
  static Future<List<ProductData>> fetchProducts() async {
    try {
      // Send a GET request to the API endpoint.
      final response = await http.get(
        Uri.parse('${AppConfig.apiURL}/api/products'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response.
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null) {
          // Extract the list of products from the "data" key.
          List<ProductData> products = [];
          for (var productJson in jsonData['data']) {
            products.add(ProductData.fromJson(productJson));
          }

          return products;
        } else {
          // Return an empty list if no products are found in the response.
          return [];
        }
      } else {
        // Throw an exception if the API request fails.
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      // Throw an exception for any error during the fetch process.
      throw Exception('Error during fetching products: $e');
    }
  }

  static Future<List<DataCategory>> fetchCategory() async {
    var response =
        await http.get(Uri.parse('${AppConfig.apiURL}/api/category'));
    if (response.statusCode == 200) {
      // Decode the JSON into a List<Map<String, dynamic>>
      List<Map<String, dynamic>> jsonData =
          List<Map<String, dynamic>>.from(json.decode(response.body)["data"]);
      // Convert the List<Map<String, dynamic>> to a List<DataCategory>
      List<DataCategory> categoryList =
          jsonData.map((data) => DataCategory.fromJson(data)).toList();
      return categoryList;
    } else {
      throw Exception();
    }
  }

  static Future<SingleProduct> fetchProductByID(int product_id) async {
    try {
      // Send a GET request to the API endpoint.
      final response = await http.get(
        Uri.parse('${AppConfig.apiURL}/api/product-by-id/$product_id'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );
      if (response.statusCode == 200) {
        // Parse the JSON response.
        final jsonData = json.decode(response.body);
        final product = SingleProduct.fromJson(jsonData);
        return product;
      } else {
        // Throw an exception if the API request fails.
        print('Failed to fetch product: ${response.statusCode}');
        throw Exception('Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      // Throw an exception for any error during the fetch process.
      print('Error during fetching product: $e');
      throw Exception('Error during fetching product: $e');
    }
  }
}
