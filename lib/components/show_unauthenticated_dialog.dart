// ignore_for_file: avoid_print

import 'package:e_commerce/components/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DialogService {
  static void showUnauthenticatedDialog(String text) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unauthenticated'),
          content: CustomTextWidget(text: text),
          actions: [
            Center(
              child: Lottie.asset(
                'lib/animation/login_animation.json',
                width: 100,
                height: 100,
                onLoaded: (composition) {
                  // Animation is loaded successfully.
                },
                onWarning: (dynamic error) {
                  print('Error loading Lottie animation: $error');
                  // Handle error loading animation
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
