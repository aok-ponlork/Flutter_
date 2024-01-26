// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_element, prefer_typing_uninitialized_variables
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/search_delegator.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowProductByCategory extends StatelessWidget {
  final List<ProductData> productByCategory;
  const ShowProductByCategory({super.key, required this.productByCategory});
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    final TextEditingController _searchController = TextEditingController();
    final FocusNode _searchFocusNode = FocusNode();

    void _showSearchDelegate(BuildContext context) {
      showSearch(
        context: context,
        delegate: ProductSearchDelegate(productController.productList),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 233, 222, 229),
      body: SingleChildScrollView(
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
                    if (index < 0 || index >= productByCategory.length) {
                      return const SizedBox
                          .shrink(); // Return an empty widget if index is out of bounds
                    }
                    return ProductCard(
                      product: productByCategory[index],
                      addToCart: cartController.addToCart,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
