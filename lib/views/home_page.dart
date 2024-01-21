// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:e_commerce/components/my_drawer.dart';
import 'package:e_commerce/components/my_nav.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/views/order_page.dart';
import 'package:e_commerce/views/shop_page.dart';
import 'package:e_commerce/views/show_all_product_page.dart';
import 'package:e_commerce/views/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView {
  final RxInt selectedIndex = 0.obs;
  final List<Widget> pages = [
    const ShopPage(),
    const ShowAllProductPage(),
    const OrderedPage(),
    const UserInfo(),
  ];
  void navigatorBottomBar(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton.icon(
              onPressed: () {
                Get.toNamed('/cart');
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Obx(
                () => Text(cartController.carts.length.toString()),
              ))
        ],
      ),
      drawer: const MainDrawer(),
      backgroundColor: const Color.fromARGB(255, 233, 222, 229),
      bottomNavigationBar: Obx(
        // Wrap BottomNavBar with Obx
        () => BottomNavBar(
          onTabChange: navigatorBottomBar,
          currentIndex: selectedIndex.value,
        ),
      ),
      body: Obx(() => pages[selectedIndex.value]),
    );
  }
}
