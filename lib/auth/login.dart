// ignore_for_file: use_key_in_widget_constructors
import 'package:e_commerce/components/my_button.dart';
//import 'package:e_commerce/components/my_drawer.dart';
import 'package:e_commerce/components/my_textField.dart';
import 'package:e_commerce/components/square_tile.dart';
import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});
  @override
  Widget build(BuildContext context) {
    final AuthController controller = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Center(
              child: Text('Login page'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Obx(() {
          // Obx will rebuild when isLoading changes
          if (!controller.isLoading.value) {
            return const Opacity(
              opacity: 0.6,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Form(
            key: controller.loginFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Icons.lock,
                      size: 100,
                      shadows: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 117, 117, 117)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                              0, 3), // changes the shadow direction
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: Text(
                        "Welcome back!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 24, 24, 24),
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    LorkzTextField(
                      hintText: "Email",
                      controller: controller.emailText,
                      validation: (value) => controller.validateEmail(value),
                    ),
                    const SizedBox(height: 10),
                    LorkzTextField(
                      addEye: true,
                      isVisible: !controller.isVisible.value,
                      customUi: IconButton(
                        icon: controller.isVisible.value
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          controller.isVisible.toggle();
                        },
                      ),
                      hintText: "Password",
                      controller: controller.passwordText,
                      validation: (value) =>
                          controller.validatePassword(value, 8),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forget password?",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      onTap: () async {
                        if (controller.loginFormKey.currentState!.validate()) {
                          String? email = controller.emailText.text;
                          String? password = controller.passwordText.text;
                          await controller.login(email, password, context);
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Or continue with'),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 0.4,
                            color: Colors.black,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'lib/images/google.png'),
                        SizedBox(width: 20),
                        SquareTile(imagePath: 'lib/images/apple.png')
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        const SizedBox(width: 5),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/register');
                            },
                            child: const Text(
                              'Register now.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 73, 69, 69)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
