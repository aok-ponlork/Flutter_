import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
