// ignore_for_file: avoid_print

import 'package:e_commerce/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final DataCategory category;
  final Function()? onTapFunction;
  const CategoryRow({Key? key, required this.category, required this.onTapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunction?.call();
      },
      child: Card(
        elevation: 2, // Add some elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 100,
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white, // Use a light background color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.categoryName.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
