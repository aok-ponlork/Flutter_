// ignore_for_file: non_constant_identifier_names
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/models/single_product_model.dart';
import 'package:e_commerce/service/product_http_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class ProductCartInCart extends StatelessWidget {
  final int productId;
  final String cart_id;
  const ProductCartInCart(
      {Key? key,
      required this.productId,
      required this.cart_id,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return FutureBuilder<SingleProduct>(
      future: HttpService.fetchProductByID(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.amber,
                ),
                SizedBox(height: 8),
                Text('Loading...'),
              ],
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error loading product details: ${snapshot.error ?? "No data available"}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          SingleProduct product = snapshot.data!;
          return Column(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                        imageUrl:
                            product.data?.attributes?.image.toString() ?? '',
                        errorWidget: (context, url, error) => Image.asset(
                          'lib/images/default-product-image.png',
                          width: 40,
                          height: 40,
                        ),
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.data?.attributes?.productName ??
                                  'Unknown Product',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: \$${product.data?.attributes?.price ?? 0}', // Use a default value, e.g., 0
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.red,
                        onPressed: () {
                          if (cartController
                                  .getQuantityByCartId(int.parse(cart_id)) >
                              1) {
                            cartController.incrementOrDecrementQuantity(
                                cart_id, 'decrement');
                          }
                        },
                      ),
                      Text(
                        '${cartController.getQuantityByCartId(int.parse(cart_id))}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.green,
                        onPressed: () {
                          cartController.incrementOrDecrementQuantity(
                              cart_id, 'increment');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: const Color.fromARGB(255, 255, 0, 0),
                        onPressed: () {
                          cartController.removeFromCart(cart_id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
