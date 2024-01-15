import 'package:flutter/material.dart';
class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 218, 218, 218)),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 240, 240)
      ),
      child: Image.asset(imagePath, height: 40),
    );
  }
}
