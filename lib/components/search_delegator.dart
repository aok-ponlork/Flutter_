import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSearchDelegate extends SearchDelegate<ProductData> {
  final List<ProductData>? productList;

  ProductSearchDelegate(this.productList);

  List<ProductData> _searchResults = [];

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return ListTile(
          title: Text(product.attributes?.productName ?? 'Product Name'),
          onTap: () {
            // Implement navigation to product detail page
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      // Show a message or suggestion when the query is empty
      return const Center(
        child: Text('Start typing to search'),
      );
    } else {
      _searchResults = productList?.where((product) {
            final productName = product.attributes?.productName ?? '';
            return productName.toLowerCase().contains(query.toLowerCase());
          }).toList() ??
          [];
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ListTile(
            title: Text(product.attributes?.productName ?? 'Product Name'),
            onTap: () {
              Get.to(() => ProductDetailPage(product: product));
            },
          );
        },
      );
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ProductData());
      },
    );
  }
}
