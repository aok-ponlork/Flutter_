import 'package:flutter/material.dart';

class ShadowProductCart {
  static final verticalProductShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 8,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
     color: Colors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 8,
    offset: const Offset(0, 2)
  );
}
