// ignore_for_file: unused_local_variable

import 'package:e_commerce/auth/login.dart';
import 'package:e_commerce/auth/register.dart';
import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/views/home_page.dart';
import 'package:e_commerce/views/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final tokenController = TokenController();
  tokenController
      .readTokenFromStorage(); // Make sure to read token before initializing other controllers
  Get.put(tokenController);
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    MaterialColor customPrimaryColor = const MaterialColor(0xFFFFFBFB, {
      50: Color(0xFFFFFBFB), // You can define different shades here
      100: Color(0xFFFFFBFB),
      200: Color(0xFFFFFBFB),
      300: Color(0xFFFFFBFB),
      400: Color(0xFFFFFBFB),
      500: Color(0xFFFFFBFB),
      600: Color(0xFFFFFBFB),
      700: Color(0xFFFFFBFB),
      800: Color(0xFFFFFBFB),
      900: Color(0xFFFFFBFB),
    });
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: customPrimaryColor),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/homepage', page: () => HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
      ],
      home: const IntroPage(),
    );
  }
}
