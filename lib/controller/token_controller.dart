// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  RxString token = ''.obs;

  @override
  void onInit() {
    print(token.value);
    super.onInit();
  }

  @override
  void onClose() {
    print('TokenController disposed');
    super.onClose();
  }

  void readTokenFromStorage() {
    final box = GetStorage();
    token.value = box.read<String>('authToken') ?? '';
  }

  void updateToken(String newToken) {
    final box = GetStorage();
    box.write('authToken', newToken);
    token.value = newToken;
  }

  void clearToken() {
    final box = GetStorage();
    box.remove('authToken');
    token.value = '';
  }
}
