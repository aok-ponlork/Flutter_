// ignore_for_file: use_key_in_widget_constructors

import 'package:e_commerce/components/my_drawer.dart';
import 'package:e_commerce/components/my_nav.dart';
import 'package:e_commerce/views/cart_page.dart';
import 'package:e_commerce/views/order_page.dart';
import 'package:e_commerce/views/shop_page.dart';
import 'package:e_commerce/views/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView {
  final RxInt selectedIndex = 0.obs;
  final List<Widget> pages = [
    const ShopPage(),
    const CartPage(),
    const OrderedPage(),
    const UserInfo(),
  ];

  void navigatorBottomBar(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      backgroundColor: Colors.grey[300],
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
