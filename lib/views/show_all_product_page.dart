import 'package:e_commerce/components/product_card.dart';
import 'package:flutter/material.dart';

class ShowAllProductPage extends StatelessWidget {
  const ShowAllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [Text('Hello Lorkz'), ProductCard()],
      ),
    );
  }
}
