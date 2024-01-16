// ignore_for_file: avoid_print
import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/service/cart_http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final TokenController _tokenController = Get.put(TokenController());
  @override
  void onInit() {
    print("CartController initialized");
    fetchProductInCart();
    refresh();
    super.onInit();
  }

  var carts = [].obs;
  var isLoading = true.obs;
  void addToCart(ProductData product, int quantity) async {
    final result = await CartHttpService.addToCart(
        product, quantity, _tokenController.token.value);
    if (result == 'success') {
      // Show a success message or update the UI accordingly
      Get.snackbar('Success', 'Product added to cart successfully',
          backgroundColor: Colors.green);
      // After adding to the cart, fetch updated data
      await fetchProductInCart();
      // Now you can safely print the updated cart length
      print(carts.length.toString());
    } else if (result == 'unauthenticated') {
      // Handle unauthenticated state, maybe redirect to login
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unauthenticated'),
            content: const Text('Please log in to add products to the cart'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    const Text(
                      'Close',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.toNamed('/login');
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(color: Colors.black54),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else {
      Get.snackbar('Failed', 'Failed to add product to cart',
          backgroundColor: Colors.red);
    }
  }

  Future<void> fetchProductInCart() async {
    isLoading(true);
    try {
      print("Fetching cart data...");
      print("Token inside fetchProductInCart: ${_tokenController.token.value}");
      final cartItem = await CartHttpService.fetchProductInCart(
          _tokenController.token.value);
      if (cartItem != null) {
        carts.value = cartItem;
        print("Cart items: ${carts.length}");
      } else {
        print("Cart items are null");
      }
    } catch (e) {
      print('Error fetching Data $e');
    } finally {
      isLoading(false);
    }
  }

  void clearCart() {
    carts.clear();
    fetchProductInCart();
  }
}
