// ignore_for_file: avoid_print

import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllProductPage extends StatelessWidget {
  const ShowAllProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => print(value),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Icon(Icons.search),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 650,
            child: Center(
              child: GridView.builder(
                itemCount: productController.productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items in a row
                  crossAxisSpacing: 0, // Spacing between columns
                  mainAxisSpacing: 0, // Spacing between rows
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: productController.productList[index],
                    addToCart: cartController.addToCart,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
