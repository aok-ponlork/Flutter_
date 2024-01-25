// ignore_for_file: avoid_unnecessary_containers, avoid_print
import 'package:e_commerce/components/category_row.dart';
import 'package:e_commerce/components/header_title.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/product_cart_horizotal.dart';
import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/components/slideshow.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());

    return SingleChildScrollView(
      child: Column(
        children: [
          //search
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
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: SlideshowImages(
              imagePaths: [
                'lib/images/slide1.jpg',
                'lib/images/slide2.jpg',
                'lib/images/slide3.jpg',
              ],
            ),
          ),
          //Category
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryController.categoryList.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: CategoryRow(
                          onTapFunction: () {
                            // categoryController.fetchProductByCategory(
                            //     categoryController.categoryList[index]);
                            Get.toNamed('/product-detail');
                          },
                          category: categoryController.categoryList[index],
                        ));
                      },
                    ));
              }
            }),
          ),
          //Best sell
          const HeaderTitle(text: 'Hot pick'),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () {
              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 380,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ProductTile(
                            products: productController.productList[index],
                            addToCart: cartController.addToCart),
                      );
                    },
                  ),
                );
              }
            },
          ),
          const HeaderTitle(text: 'New product'),
          Obx(
            () {
              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: HorizontalProductCard(
                            product: productController.productList[index],
                            addToCart: cartController.addToCart),
                      );
                    },
                  ),
                );
              }
            },
          ),
          const HeaderTitle(text: 'Special Offers'),
          Obx(
            () {
              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true, // Add this line
                  physics:
                      const NeverScrollableScrollPhysics(), // Add this line
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
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
