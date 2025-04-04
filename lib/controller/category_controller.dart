// ignore_for_file: avoid_print
import 'package:e_commerce/service/product_http_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryList = [].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }
  void fetchCategory() async {
    try {
      isLoading(true);
      var category = await HttpService.fetchCategory();
      categoryList.value = category;
      print('Hello Lorkz');
    } finally {
      isLoading(false);
    }
  }
}