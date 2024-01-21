import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;
  final void Function(ProductData, int) addToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  product.attributes?.image?.toString() ??
                      'lib/images/default-product-image.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
            child: Text(
              product.attributes!.productName!.toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
            child: Text(
              '\$${product.attributes!.price!.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black54,
                  )),
              IconButton(
                  onPressed: () {
                    addToCart(product, 1);
                  },
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.black54,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
