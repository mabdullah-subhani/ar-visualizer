import 'package:ar_interior_visualizer/src/features/visualization/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/appbar/appbar.dart';
import '../../../common_widgets/layouts/grid_layout/grid_layout.dart';
import '../../../common_widgets/loaders/shimmer/vertical_product_shimmer.dart';
import '../../../common_widgets/products/product_cards/product_card_vertical.dart';
import '../../../utils/constants/sizes.dart';
import '../models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>(); // Use Get.find to get the controller instead of Get.put

    // Schedule the fetch of category products after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCategoryProducts(category.name);
    });

    return Scaffold(
      appBar: MyAppBar(title: Text(category.name), showBackArrow: true, colorMode: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
          child: Obx(() {
            // Show loading shimmer while fetching data
            if (controller.isLoading.value) return const MyAppVerticalProductShimmer();

            // Handle the case when no products are found
            if (controller.categoryProducts.isEmpty) {
              return Center(
                child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium),
              );
            }

            // Display products once they are fetched
            return MyAppGridLayout(
              itemCount: controller.categoryProducts.length,
              itemBuilder: (_, index) => MyAppProductCardVertical(
                product: controller.categoryProducts[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
