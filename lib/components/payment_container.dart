// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PaymentContainer extends StatelessWidget {
  var totalPrice = 0;
  PaymentContainer({super.key, required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Container(
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
             Center(
              child: Text(
                'Total Price: $totalPrice',
                style: const TextStyle(
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
                backgroundColor: const Color.fromARGB(255, 134, 236, 137),
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
    );
  }
}
