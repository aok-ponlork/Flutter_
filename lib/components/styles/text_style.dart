import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  const CustomTextWidget({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontFamily: 'SpaceMono',
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: Colors.black87),
    );
  }
}
