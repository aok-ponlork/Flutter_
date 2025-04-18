// ignore_for_file: avoid_unnecessary_containers, avoid_print, no_leading_underscores_for_local_identifiers
import 'package:e_commerce/components/category_row.dart';
import 'package:e_commerce/components/header_title.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/product_cart_horizotal.dart';
import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/components/search_delegator.dart';
import 'package:e_commerce/components/slideshow.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/views/show_product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final ProductController productController = Get.put(ProductController());
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
                    itemCount: productController.mostSaleCount.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ProductTile(
                            products: productController.mostSaleCount[index],
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
                    itemCount: productController.newProduct.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: HorizontalProductCard(
                            product: productController.newProduct[index],
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
                  itemCount: productController.specialProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items in a row
                    crossAxisSpacing: 0, // Spacing between columns
                    mainAxisSpacing: 0, // Spacing between rows
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: productController.specialProduct[index],
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
