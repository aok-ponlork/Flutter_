import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                'lib/images/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 10),
            //Title
            const Text(
              'WELCOME',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 31, 31),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            //Subtitle
            const Text(
              'Welcome to our e-commerce haven! 🛍️ Ready to shop till you drop? Explore our vast selection of top-notch products and unbeatable deals. Let\'s buy some things! 🎉',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Color.fromARGB(255, 101, 101, 101), fontSize: 20),
            ),
            const SizedBox(height: 40),
          
            //Button to home page
            GestureDetector(
              onTap: () {
                Get.toNamed('/homepage');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: const Center(
                    child: Text(
                      'SHOP NOW',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
                  ],
                ),
          )),
    );
  }
}
