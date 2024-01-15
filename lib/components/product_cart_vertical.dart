import 'package:e_commerce/components/styles/shadow.dart';
import 'package:flutter/material.dart';

class ProductCartVertical extends StatelessWidget {
  const ProductCartVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [ShadowProductCart.verticalProductShadow],
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300]
      ),
      child: Column(children: [
        //Image
      ]),
    );
  }
}