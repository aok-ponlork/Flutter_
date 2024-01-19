// ignore_for_file: avoid_print

import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/service/product_http_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductData>[].obs;
  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }
  void fetchProduct() async {
    try {
      isLoading(true);
      var products = await HttpService.fetchProducts();
      productList.value = products;
    } catch (e) {
      // Handle or log the error as needed
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }
}
