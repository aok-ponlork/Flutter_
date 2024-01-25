import 'package:e_commerce/components/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService {
  static void showUnauthenticatedDialog(String text) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unauthenticated'),
          content: CustomTextWidget(text: text),
          actions: [
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
