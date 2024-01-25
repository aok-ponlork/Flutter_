// ignore_for_file: must_be_immutable

import 'package:e_commerce/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentContainer extends StatelessWidget {
  String totalPrice;
  PaymentContainer({super.key, required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Color.fromARGB(255, 220, 217, 217),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 50),
        child: Column(
          children: [
            Center(
              child: Text(
                'Total Price:  $totalPrice',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Remove the dollar sign from the total price
                String sanitizedTotalPrice = totalPrice.replaceAll('\$', '');
                // Parse the sanitized total price as a double
                double parsedTotalPrice = double.parse(sanitizedTotalPrice);
                // Now, use the parsedTotalPrice in your initiatePayment method
                paymentController.initiatePayment(false, parsedTotalPrice, '');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 46, 45, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Check out',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
