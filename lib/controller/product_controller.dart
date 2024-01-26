// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/service/product_http_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductData>[].obs;
  var mostSaleCount = <ProductData>[].obs;
  var specialProduct = <ProductData>[].obs;
  var newProduct = <ProductData>[].obs;
  var productByCategory_id = <ProductData>[].obs;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void fetchProduct() async {
    try {
      isLoading(true);
      var products = await HttpService.fetchProducts();
      print(products);
      productList.value = products;
      getMostSaleCountProducts();
      specialProduct.value = productList.reversed.take(10).toList();
      newProduct.value = productList.reversed.take(6).toList();
    } catch (e) {
      // Handle or log the error as needed
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void getMostSaleCountProducts() {
    // Sort the productList based on the saleCount attribute
    productList.sort((a, b) =>
        (b.attributes?.saleCount ?? 0).compareTo(a.attributes?.saleCount ?? 0));
    // Take the top 8 products with the highest sale count
    mostSaleCount.value = productList.take(8).toList();
  }

  void getProductByCategoryID(int categoryID) {
    // Filter the productList to get products with the specified categoryID
    productByCategory_id.value = productList
        .where((product) => product.relationship?.categoryId == categoryID)
        .toList();
  }
}
