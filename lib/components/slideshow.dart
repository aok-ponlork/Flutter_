import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlideshowImages extends StatelessWidget {
  final List<String> imagePaths;

  const SlideshowImages({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      items: imagePaths.map(buildSlideContainer).toList(),
      options: CarouselOptions(
        height: 190,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        enlargeCenterPage: true,
        viewportFraction: screenWidth / screenWidth,
      ),
    );
  }

  Widget buildSlideContainer(String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 71, 71, 71).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover // Maintain aspect ratio and cover the container
      ),
    );
  }
}
