// ignore_for_file: constant_identifier_names

import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/order_detail_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:get/get.dart';

class AppConfig {
  static const String apiURL = 'http://192.168.1.3:8000';
  static void refreshData() {
    final UserController userController = Get.put(UserController());
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    final OrderDetailController orderDetailController =
        Get.put(OrderDetailController());
    productController.fetchProduct();
    cartController.fetchProductInCart();
    orderDetailController.fetchOrderData();
    userController.fetchUserInfo();
  }
}
