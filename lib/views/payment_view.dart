// ignore_for_file: use_key_in_widget_constructors

import 'package:e_commerce/components/category_row.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return ElevatedButton(onPressed: () {}, child: const Text('Click to pay'));
  }
}
