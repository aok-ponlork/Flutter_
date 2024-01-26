// ignore_for_file: use_key_in_widget_constructors, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 233, 222, 229),
      body: Column(
        children: [
          Lottie.asset(
            'lib/animation/us.json',
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
          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoCard(
                  title: 'Name',
                ),
                UserInfoCard(
                  title: 'Email',
                ),
                UserInfoCard(
                  title: 'Created At',
                ),
                UserInfoCard(
                  title: 'Total Spent',
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

  const UserInfoCard({
    required this.title,
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
        ],
      ),
    );
  }
}
