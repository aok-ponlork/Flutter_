// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'lib/animation/empty_order.json',
            width: 350,
            height: 350,
            onLoaded: (composition) {
              // Animation is loaded successfully.
            },
            onWarning: (dynamic error) {
              print('Error loading Lottie animation: $error');
              // Handle error loading animation
            },
          ),
          const Center(
            child: Text(
              'It seems like you haven\'t placed any orders yet.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SpaceMono',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
