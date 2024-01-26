// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_element

import 'package:e_commerce/components/category_row.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/search_delegator.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/views/show_product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllProductPage extends StatelessWidget {
  const ShowAllProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    final CategoryController categoryController = Get.put(CategoryController());
    final TextEditingController _searchController = TextEditingController();
    final FocusNode _searchFocusNode = FocusNode();

    void _showSearchDelegate(BuildContext context) {
      showSearch(
        context: context,
        delegate: ProductSearchDelegate(productController.productList),
      );
    }

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
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onTap: () {
                      _showSearchDelegate(context);
                    },
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
            padding: const EdgeInsets.only(top: 15),
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
                        final category = categoryController.categoryList[index];
                        return Center(
                            child: CategoryRow(
                          onTapFunction: () {
                            productController
                                .getProductByCategoryID(category.categoryId);
                            Get.to(() => ShowProductByCategory(
                                  productByCategory: productController
                                      .productByCategory_id
                                      .toList(),
                                ));
                          },
                          category: category,
                        ));
                      },
                    ));
              }
            }),
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
