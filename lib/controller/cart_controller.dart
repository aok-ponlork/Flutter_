// ignore_for_file: avoid_print

import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/service/cart_http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  bool isInitialized = false;

  void initialize() {
    ever(carts, (_) {
      fetchProductInCart(forceRefresh: true);
      handleAuthenticationStateChange();
    });
    fetchProductInCart();
    refresh();
    isInitialized = true;
  }

  @override
  void onInit() {
    ever(carts, (_) {
      // This block will be executed whenever carts change
      // (i.e., whenever items are added or removed from the cart)
      fetchProductInCart(forceRefresh: true);
      handleAuthenticationStateChange();
    });
    fetchProductInCart();
    refresh();
    super.onInit();
  }

  var carts = <CartData>[].obs;
  var isLoading = true.obs;
  void addToCart(ProductData product, int quantity) async {
    final result = await CartHttpService.addToCart(product, quantity);
    if (result == 'success') {
      // Show a success message or update the UI accordingly
      Get.snackbar('Success', 'Product added to cart successfully',
          backgroundColor: Colors.green);
      refresh();
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

  Future<void> fetchProductInCart({bool forceRefresh = false}) async {
    if (!forceRefresh && carts.isNotEmpty) {
      // Do not fetch if data is already available and not forced to refresh
      return;
    }
    isLoading(true);
    try {
      final cartItem = await CartHttpService.fetchProductInCart();
      if (cartItem != null) {
        carts.value = cartItem;
      }
    } catch (e) {
      print('Error fetching Data $e');
    } finally {
      isLoading(false);
    }
  }

  void handleAuthenticationStateChange() {
    // Fetch fresh cart data only if the cart was not cleared
    if (carts.isEmpty) {
      fetchProductInCart(forceRefresh: true);
    }
  }

  void clearCart() {
    carts.clear();
  }
}
