import 'package:e_commerce/components/category_row.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                return Center(
                    child: CategoryRow(
                      onTapFunction: () {
                        
                      },
                  category: controller.categoryList[index],
                ));
              },
            ));
      }
    });
  }
}
