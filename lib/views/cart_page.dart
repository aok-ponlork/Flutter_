// ignore_for_file: unused_element, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:e_commerce/components/empty_cart.dart';
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
    return Obx(() {
      final hasToken = _tokenController.token.value.isEmpty;
      if (hasToken) {
        return const EmptyCart();
      }
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.carts.isEmpty) {
        return  Center(
          child: Column(
            children: [const EmptyCart(), Text('${controller.carts.length}')],
          ),
        );
      } else {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Obx(() => Center(
                          child: Text(
                            'Number of Items: ${controller.carts.length}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 50),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Total Price:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 134, 236, 137),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Pay with Paypal',
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 74, 74),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }

  String _truncateTitle(String title) {
    if (title.length > 30) {
      return '${title.substring(0, 27)}...';
    }
    return title;
  }
}
