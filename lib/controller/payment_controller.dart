// controllers/payment_controller.dart
// ignore_for_file: avoid_print
import 'package:e_commerce/config/env.dart';
import 'package:e_commerce/web_view/paypal_payment_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> initiatePayment(double amount) async {
    try {
      isLoading.value = true;

      const apiUrl = '${AppConfig.apiURL}/api/charge';
      final response = await http
          .post(Uri.parse(apiUrl), body: {'amount': amount.toString()});

      if (response.statusCode == 200) {
        final paymentUrl = json.decode(response.body)['redirect_url'];
        await launchPaymentWebView(paymentUrl);
      } else {
        // Handle error
        print('Payment initiation failed: ${response.body}');
        showSnackbar('Payment initiation failed', true);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void handlePaymentResult(String? resultUrl) {
    if (resultUrl != null && resultUrl.startsWith(AppConfig.apiURL)) {
      // Parse the result URL and extract parameters
      final Uri uri = Uri.parse(resultUrl);
      final bool success = uri.queryParameters['success'] == 'true';
      final String message =
          uri.queryParameters['message'] ?? 'Payment result unknown';
      // Show snackbar based on success
      showSnackbar(message, !success);
    }
  }

  Future<void> launchPaymentWebView(String paymentUrl) async {
    // Assuming this method is inside a stateful/widget class
    if (await canLaunchUrl(Uri.parse(paymentUrl))) {
      Navigator.push(
        // Use the context available in the widget class
        Get.context!,
        MaterialPageRoute(
          builder: (context) => WebViewWithAppBar(url: paymentUrl),
        ),
      );
    } else {
      // Handle error if the URL can't be launched
      print('Could not launch payment URL: $paymentUrl');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Could not launch payment URL')));
    }
  }

  void showSnackbar(String message, bool isError) {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }
}
