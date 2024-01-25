// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:e_commerce/components/show_unauthenticated_dialog.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
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
    super.onInit();
  }

  double get totalPrice => carts.fold(0, (total, cartItem) {
        // Calculate the subtotal for each cart item and add it to the total
        return total +
            (double.parse(cartItem.product_price) * cartItem.quantity);
      });
  var carts = [].obs;
  var total = 0.0.obs;
  var isLoading = true.obs;
  void addToCart(ProductData product, int quantity) async {
    print(product.id);
    bool productExisting = carts.any((item) {
      // Trim any leading/trailing whitespace
      String trimmedProductId = item.productId?.toString().trim() ?? '';
      String trimmedProductIdToCompare = product.id?.trim() ?? '';
      return trimmedProductId == trimmedProductIdToCompare;
    });
    if (productExisting) {
      Get.snackbar('Opp!', 'Product in already in the cart!',
          backgroundColor: Colors.red);
    } else {
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
        DialogService.showUnauthenticatedDialog('Please log in to add products to the cart');
      } else {
        Get.snackbar('Failed', 'Failed to add product to cart!',
            backgroundColor: Colors.red);
      }
    }
  }

  Future<void> fetchProductInCart() async {
    isLoading(true);
    try {
      final cartItem = await CartHttpService.fetchProductInCart(
          _tokenController.token.value);
      if (cartItem != null) {
        carts.value = cartItem;
        print("Cart items: ${carts.length}");
      } else {
        clearCart();
      }
    } catch (e) {
      print('Error fetching Data $e');
    } finally {
      isLoading(false);
    }
  }

  void removeFromCart(String cart_id) async {
    try {
      isLoading(true);
      final response = await CartHttpService.removeFromCart(
          cart_id, _tokenController.token.value);
      if (response) {
        fetchProductInCart();
      }
    } catch (e) {
      print('Error fetching Data $e');
    } finally {
      isLoading(false);
    }
  }

  void incrementOrDecrementQuantity(String cart_id, String action) async {
    try {
      // Set loading state to true before making the API call
      isLoading(true);
      // Make the API call to increment or decrement the quantity
      final response = await CartHttpService.incrementOrDecrement(
        cart_id,
        action,
        _tokenController.token.value,
      );
      // If the API call is successful, fetch the updated cart data
      if (response) {
        fetchProductInCart();
      }
    } catch (e) {
      // Handle errors, print or log the error for debugging
      print('Error $action Data $e');
    } finally {
      // Set loading state to false regardless of the outcome
      isLoading(false);
    }
  }

  int getQuantityByCartId(int cartId) {
    // Assuming carts is a list of CartData objects
    CartData? cartItem =
        carts.firstWhere((item) => item.id == cartId, orElse: () => null);
    return cartItem?.quantity ?? 0;
  }

  void clearCart() {
    carts.clear();
  }
}
