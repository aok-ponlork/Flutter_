import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Adjust the corner radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image placeholder (replace with actual image)
          Container(
            height: 200, // Adjust image height
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12)), // Rounded top corners
              image: DecorationImage(
                image: AssetImage(
                    'lib/images/default-product-image.png'), // Replace with actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text content placeholder (replace with actual text)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Product Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Button placeholder (replace with actual button)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {}, // Add button action here
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Use a soft color scheme
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Adjust the corner radius
                ),
              ),
              child: const Text('Add to Cart'),
            ),
          )
        ],
      ),
    );
  }
}
