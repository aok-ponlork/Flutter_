import 'package:e_commerce/components/my_button.dart';
import 'package:e_commerce/components/my_textField.dart';
import 'package:e_commerce/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController controller = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Obx(() {
          if (!controller.isLoading.value) {
            return const Opacity(
              opacity: 0.6,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Form(
            key: controller.registerFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Icons.app_registration_rounded,
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
                        "Let's create an Account!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 24, 24, 24),
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    LorkzTextField(
                      hintText: "Username",
                      controller: controller.nameText,
                      validation: (p0) => controller.validateName(p0, 2),
                    ),
                    const SizedBox(height: 10),
                    LorkzTextField(
                      hintText: "Email",
                      controller: controller.emailTextRegistser,
                      validation: (p0) => controller.validateEmail(p0),
                    ),
                    const SizedBox(height: 10),
                    LorkzTextField(
                      hintText: "Password",
                      controller: controller.passwordTextRegister,
                      validation: (p0) => controller.validatePassword(p0, 8),
                    ),
                    const SizedBox(height: 40),
                    MyButton(
                      onTap: () {
                        if (controller.registerFormKey.currentState!
                            .validate()) {
                          final String email =
                              controller.emailTextRegistser.text;
                          final String password =
                              controller.passwordTextRegister.text;
                          final String username = controller.nameText.text;
                          controller.register(email, password, username, context);
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton(
                                onPressed: () {
                                  Get.offAllNamed('/login');
                                },
                                child: const Text('Already have an account',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 34, 34, 34)))),
                          ),
                          const Expanded(
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
                    const SizedBox(
                      height: 35,
                    ),
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
