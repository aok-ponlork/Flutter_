// ignore_for_file: unused_element, avoid_print, no_leading_underscores_for_local_identifiers
import 'package:e_commerce/components/empty_order.dart';
import 'package:e_commerce/components/order_detail_card.dart';
import 'package:e_commerce/controller/order_detail_controller.dart';
import 'package:e_commerce/controller/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderedPage extends StatelessWidget {
  const OrderedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final OrderDetailController controller = Get.put(OrderDetailController());
    final TokenController _tokenController = Get.put(TokenController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 222, 229),
      body: Obx(() {
        final hasToken = _tokenController.token.value.isEmpty;
        if (hasToken) {
          return const EmptyOrder();
        }
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.orderDetailList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [EmptyOrder()],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.orderDetailList.length,
                    itemBuilder: (context, index) {
                      return ProductCartInOder(
                        productId: controller.orderDetailList[index].productId!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      }),
    );
  }
}
