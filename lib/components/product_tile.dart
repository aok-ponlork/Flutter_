// ignore_for_file: must_be_immutable, avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  ProductData products;
  void Function(ProductData, int) addToCart;
  ProductTile({super.key, required this.products, required this.addToCart});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 20),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //Product Image
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.amber,
              ),
              imageUrl: products.attributes?.image.toString() ?? 'lib/images/default-product-image.png',
              errorWidget: (context, url, error) => Image.asset(
                'lib/images/default-product-image.png',
                width: 250,
                height: 250,
              ),
            ),
          ),
        ),

        //Product name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: Text(
            products.attributes!.productName!.toString(),
            style: const TextStyle(color: Color.fromARGB(221, 45, 45, 45)),
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                children: [
                  Text(
                    products.attributes!.stockQty!.toString(),
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
                    '\$${products.attributes!.price!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                addToCart(products, 1);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6))),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
