// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers
import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key});
  @override
  Widget build(BuildContext context) {
    final TokenController _tokenController = Get.put(TokenController());
    final AuthController _authController = Get.put(AuthController());
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
          Obx(() => Padding(
                padding: const EdgeInsets.all(25),
                child: ListTile(
                  leading: _tokenController.token.value.isNotEmpty
                      ? const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                  title: _tokenController.token.value.isNotEmpty
                      ? const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                  onTap: () {
                    if (_tokenController.token.value.isNotEmpty) {
                      // Handle logout
                      _authController.handleLogout();
                    } else {
                      // Handle login
                      Get.toNamed('/login');
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }
}
