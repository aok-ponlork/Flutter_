// ignore_for_file: avoid_print

import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/service/user_http_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final TokenController _tokenController = Get.put(TokenController());
  RxMap userInfo = {}.obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading(true);
      final userData =
          await UserHttpService.getUserInfo(_tokenController.token.value);
      if (userData != null) {
        userInfo = userData.obs; // Update the observable map with user info
      } else {
        throw Exception('User info is null');
      }
    } catch (e) {
      // Handle or log the error as needed
      print('Error fetching user info: $e');
    } finally {
      isLoading(false);
    }
  }
}
