// ignore_for_file: use_key_in_widget_constructors
import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/service/auth_http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[850],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                  color: Colors.white,
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Divider(
                  color: Colors.grey[100],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  leading: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: ListTile(
              leading: AuthController().token.value.isEmpty
                  ? const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
              title: AuthController().token.value.isEmpty
                  ? const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
              onTap: () {
                Navigator.pop(context);
                if (AuthController().token.value.isEmpty) {
                  // Handle logout
                  CartController().handleAuthenticationStateChange();
                  AuthService.logout();
                } else {
                  // Handle login
                  Get.toNamed('/login');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
