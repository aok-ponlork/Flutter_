// ignore_for_file: unused_element, avoid_print

import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final authController = Get.find<AuthController>();

    return Obx(() {
      final hasToken = authController.token.value.isEmpty;

      if (!hasToken) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Display your dialog or navigate to login
          // (Note: This part is currently missing in your code)
        });
      }

      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.carts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'lib/animation/empty_cart_animation.json',
                width: 300,
                height: 300,
                onLoaded: (composition) {
                  // Animation is loaded successfully.
                },
                onWarning: (dynamic error) {
                  print('Error loading Lottie animation: $error');
                  // Handle error loading animation
                },
              ),
              const Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            ],
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
