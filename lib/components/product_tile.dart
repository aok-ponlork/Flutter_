// ignore_for_file: must_be_immutable, avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductData products;
  final void Function(ProductData, int) addToCart;
  const ProductTile({Key? key, required this.products, required this.addToCart})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 20),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 71, 71, 71).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product Image
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: CachedNetworkImage(
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: Color.fromARGB(255, 248, 227, 165),
                ),
                imageUrl: products.attributes?.image?.toString() ??
                    'lib/images/default-product-image.png',
                errorWidget: (context, url, error) => Image.asset(
                  'lib/images/default-product-image.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),

          // Product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text(
                products.attributes!.productName?.toString() ?? '',
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),

          // Stock Quantity and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  children: [
                    Text(
                      products.attributes?.stockQty?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '\$${products.attributes?.price?.toStringAsFixed(2) ?? ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Add to Cart Button
              GestureDetector(
                onTap: () {
                  addToCart(products, 1);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
