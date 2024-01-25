import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/styles/text_style.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/payment_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductData product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final ProductController productController = Get.put(ProductController());
    final PaymentController paymentController = Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Color.fromARGB(255, 248, 227, 165),
              ),
              imageUrl: product.attributes?.image?.toString() ??
                  'lib/images/default-product-image.png',
              errorWidget: (context, url, error) => Image.asset(
                'lib/images/default-product-image.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Floating Container with Product Information and Button
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.attributes!.productName?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.attributes!.description?.toString() ?? '',
                    style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price: \$${product.attributes?.price?.toStringAsFixed(2) ?? ''}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          cartController.addToCart(product, 1);
                        },
                        icon: const Icon(Icons.shopping_cart),
                        iconSize: 40,
                      ),
                      Obx(() {
                        if (paymentController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.amber),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              //Add isFastBuy = true;
                              paymentController.initiatePayment(
                                  true, product.attributes!.price!, product.id.toString());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Buy now!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SpaceMono',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CustomTextWidget(text: 'Related product'),
                  Obx(
                    () {
                      if (productController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox(
                          height: 300, // Set a fixed height for the GridView
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productController.productList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 1.4,
                            ),
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: productController.productList[index],
                                addToCart: cartController.addToCart,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
