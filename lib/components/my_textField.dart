// ignore_for_file: prefer_typing_uninitialized_variables, file_names
import 'package:flutter/material.dart';

class LorkzTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final bool addEye;
  final bool isVisible;
  final Widget? customUi;
  const LorkzTextField({
    Key? key,
    this.customUi,
    required this.hintText,
    required this.controller,
    this.addEye = false,
    this.validation,
    this.isVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: isVisible,
        decoration: InputDecoration(
          suffixIcon: addEye
              ? customUi : null,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 35, 35, 35)),
          ),
          fillColor: const Color.fromARGB(255, 223, 223, 223),
          filled: true,
          hintText: hintText,
        ),
        validator: validation,
      ),
    );
  }
}
