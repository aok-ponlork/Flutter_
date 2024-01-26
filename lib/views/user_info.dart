// ignore_for_file: use_key_in_widget_constructors, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TokenController _tokenController = Get.put(TokenController());
    final UserController _userController = Get.put(UserController());

    return Obx(() {
      final dontHaveToken = _tokenController.token.value.isEmpty;
      if (dontHaveToken) {
        return Center(
          child: Lottie.asset(
            'lib/animation/login_animation.json',
            width: 300,
            height: 300,
            onLoaded: (composition) {
              // Animation is loaded successfully.
            },
            onWarning: (dynamic error) {
              print('Error loading Lottie animation: $error');
              // Handle error loading animation
            },
          ),
        );
      }
      if (_userController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                'lib/animation/user.json',
                width: 400,
                height: 400,
                onLoaded: (composition) {
                  // Animation is loaded successfully.
                },
                onWarning: (dynamic error) {
                  print('Error loading Lottie animation: $error');
                  // Handle error loading animation
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoCard(
                      title: 'Name',
                      value: _userController.userInfo['user_name'] ?? '',
                    ),
                    UserInfoCard(
                      title: 'Email',
                      value: _userController.userInfo['user_email'] ?? '',
                    ),
                    UserInfoCard(
                      title: 'Created At',
                      value: _userController.userInfo['created_at'] ?? '',
                    ),
                    UserInfoCard(
                        title: 'Total Spent',
                        value:
                            _userController.userInfo['total_spend'].toString())
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}

class UserInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const UserInfoCard({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'SpaceMono',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'SpaceMono',
            ),
          ),
        ],
      ),
    );
  }
}
