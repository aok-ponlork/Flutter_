// ignore_for_file: use_key_in_widget_constructors

import 'package:e_commerce/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => controller.initiatePayment(false, 100.0, ''), //IsfastBuy and amount
                child: const Text('Click to pay'),
              ),
            ],
          ),
        );
      }
    });
  }
}
