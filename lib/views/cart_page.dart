// ignore_for_file: unused_element, avoid_print, no_leading_underscores_for_local_identifiers
import 'package:e_commerce/components/empty_cart.dart';
import 'package:e_commerce/components/payment_container.dart';
import 'package:e_commerce/components/product_card_in_cart.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());
    final TokenController _tokenController = Get.put(TokenController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        final hasToken = _tokenController.token.value.isEmpty;
        if (hasToken) {
          return const EmptyCart();
        }
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.carts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const EmptyCart(), Text('${controller.carts.length}')],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.carts.length,
                    itemBuilder: (context, index) {
                      return ProductCartInCart(
                        productId: controller.carts[index].productId,
                        cart_id: controller.carts[index].id.toString(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                PaymentContainer(
                    totalPrice: '\$${controller.totalPrice.toStringAsFixed(2)}')
              ],
            ),
          );
        }
      }),
    );
  }

  String _truncateTitle(String title) {
    if (title.length > 30) {
      return '${title.substring(0, 27)}...';
    }
    return title;
  }
}
