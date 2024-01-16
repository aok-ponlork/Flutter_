// ignore_for_file: avoid_unnecessary_containers
import 'package:e_commerce/components/category_row.dart';
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SlideshowImages(
                imageSliders: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 50,
                  ),
                  Image.asset(
                    'lib/images/google.png',
                    height: 50,
                  ),
                  Image.asset(
                    'lib/images/apple.png',
                    height: 50,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Obx(() {
              if (productController.isLoading.value) {
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
                            categoryController.fetchProductByCategory(
                                categoryController.categoryList[index]);
                          },
                          category: categoryController.categoryList[index],
                        ));
                      },
                    ));
              }
            }),
          ),
          //Best sell
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Porpula',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87),
                  )
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () {
              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 450,
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
        ],
      ),
    );
  }
}
