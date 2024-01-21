// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int currentIndex;

  const BottomNavBar({Key? key, required this.onTabChange, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 55, 55, 55),
        selectedItemColor: const Color.fromARGB(255, 30, 30, 30),
        unselectedItemColor: const Color.fromARGB(255, 110, 110, 110),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: (value) => onTabChange!(value),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Ordered',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}