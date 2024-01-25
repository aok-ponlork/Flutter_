// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'User Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'SpaceMono',
            ),
          ),
          // Your animation widget here
          Lottie.asset(
            'lib/animation/user.json',
            width: 200,
            height: 200,
            onLoaded: (composition) {
              // Animation is loaded successfully.
            },
            onWarning: (dynamic error) {
              print('Error loading Lottie animation: $error');
              // Handle error loading animation
            }
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                UserInfoCard(
                  title: 'Name',
                  value: 'John Doe', // Replace with actual user name
                ),
                UserInfoCard(
                  title: 'Email',
                  value: 'john@example.com', // Replace with actual user email
                ),
                UserInfoCard(
                  title: 'Created At',
                  value: '2024-01-20', // Replace with actual user creation date
                ),
                UserInfoCard(
                  title: 'Total Spent',
                  value: '\$1000', // Replace with actual total spent by user
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
