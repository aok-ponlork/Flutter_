// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:e_commerce/components/styles/text_style.dart';
import 'package:e_commerce/config/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWithAppBar extends StatefulWidget {
  final String url;
  const WebViewWithAppBar({Key? key, required this.url}) : super(key: key);
  @override
  _WebViewWithAppBarState createState() => _WebViewWithAppBarState();
}

class _WebViewWithAppBarState extends State<WebViewWithAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(text: 'Pay with Paypal.'),
        backgroundColor: Colors.transparent, // Set app bar background color
        elevation: 0, // Remove app bar shadow
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          // This callback is called when the WebView starts loading a new page
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          // This callback is called when the WebView finishes loading a page
          print('Page finished loading: $url');
          // Check if the URL indicates a successful payment, and navigate back if needed
          if (url.startsWith('${AppConfig.apiURL}/api/success?')) {
            // URL parameters to check for success
            Navigator.pop(context);
            Get.snackbar(
              'Payment',
              'Success',
              backgroundColor: Colors.green[400], // Snackbar background color
              colorText: Colors.white, // Text color
              animationDuration: const Duration(seconds: 1),
            ); // Go back to the previous screen
            AppConfig.refreshData();
          } else if (url.startsWith('${AppConfig.apiURL}/api/error?')) {
            Navigator.pop(context);
            Get.snackbar('Cancel payment', 'You have been cancel your Payment!',
                backgroundColor: Colors.red[400], // Snackbar background color
                colorText: Colors.white, // Text color
                animationDuration: const Duration(seconds: 1));
          }
        },
      ),
      backgroundColor: const Color.fromARGB(255, 233, 222, 229),
    );
  }
}
