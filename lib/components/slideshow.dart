import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlideshowImages extends StatelessWidget {
  final List<Widget> imageSliders;

  const SlideshowImages({Key? key, required this.imageSliders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
        height: 100, // Adjust height as needed
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
