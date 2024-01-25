// ignore_for_file: avoid_print

import 'package:e_commerce/controller/token_controller.dart';
import 'package:e_commerce/models/order_detail_model.dart';
import 'package:e_commerce/service/order_detail_service.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  var isLoading = true.obs;
  var orderDetailList = <OrderDetail>[].obs;
  final TokenController _tokenController = Get.put(TokenController());

  @override
  void onInit() {
    fetchOrderData();
    super.onInit();
  }

  void fetchOrderData() async {
    try {
      isLoading(true);
      // Fetch order data from the service
      final List<OrderDetail>? data =
          await OrderDetailService.fetchOrderData(_tokenController.token.value);
      // Check if data is not null
      if (data != null) {
        // Update the orderDetailList with the fetched data
        orderDetailList.assignAll(data);
      }
    } catch (e) {
      // Handle or log the error as needed
      print('Error fetching order data: $e');
    } finally {
      isLoading(false);
    }
  }
}
