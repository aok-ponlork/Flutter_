// ignore_for_file: file_names, use_build_context_synchronously
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/service/auth_http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class AuthController extends GetxController {
  final TokenController _tokenController = Get.put(TokenController());
  final CartController _cartController = Get.put(CartController());
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  RxBool isVisible = true.obs;
  var isLoading = true.obs;
  TextEditingController passwordText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  TextEditingController nameText = TextEditingController();
  TextEditingController emailTextRegistser = TextEditingController();
  TextEditingController passwordTextRegister = TextEditingController();
  @override
  void onInit() {
    // Initialize the controller
    _tokenController.readTokenFromStorage();
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose the controller when not needed
    nameText.dispose();
    emailText.dispose();
    passwordText.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    final bool isValid = EmailValidator.validate(value!);
    if (value.isEmpty) {
      return 'Please enter an email address.';
    } else if (!isValid) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validateName(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    } else if (value.length < length) {
      return 'Username must be at laest $length characters.';
    }
    return null;
  }

  String? validatePassword(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    } else if (value.length < length) {
      return 'Password must be at least $length characters.';
    }
    return null;
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      isLoading(false);
      String? isLoggedIn = await AuthService.login(email, password);
      if (isLoggedIn == null) {
        // Navigate to the home page on successful login
        Get.toNamed('homepage');
      } else {
        showErrorDialog(context, isLoggedIn);
      }
    } catch (error) {
      showErrorDialog(context, 'An error occurred: $error');
    } finally {
      isLoading(true);
    }
  }

  Future<void> register(String email, String password, String userName,
      BuildContext context) async {
    try {
      isLoading(false);
      String? result = await AuthService.register(userName, email, password);
      if (result == 'Register success!') {
        // Navigate to the home page on successful login
        Get.toNamed('homepage');
      } else {
        showErrorDialog(context, result!);
      }
    } catch (error) {
      showErrorDialog(context, 'An error occurred: $error');
    } finally {
      isLoading(true);
    }
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void handleLogout() {
    // Clear cart data
    _cartController.clearCart();
    // Other logout logic
    AuthService.logout();
  }
}
