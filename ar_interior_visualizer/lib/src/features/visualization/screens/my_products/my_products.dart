import 'package:ar_interior_visualizer/src/common_widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ar_interior_visualizer/src/features/visualization/controllers/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/icons/circular_icon.dart';
import '../../../../common_widgets/loaders/shimmer/horizontal_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../upload_item/upload_Item.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());
    controller.isDataUpdated.value = true;

    return Scaffold(
      appBar: MyAppBar(
        title: Text('My Products',
            style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          MyAppCircularIcon(
              icon: Iconsax.document_upload,
              onPressed: () => Get.to(const UploadItemScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),

          /// -- My Products List

          child: Obx(() {
            // Trigger fetchUserItems when data is updated
            if (controller.isDataUpdated.value) {
              controller.fetchUserItems();
            }
            if (controller.isLoading.value) return const MyAppHorizontalProductShimmer();
            if (controller.allItems.isEmpty) {
              return Center(
                  child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
            }              return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.allItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: MyAppSizes.spaceBtwSections),
              itemBuilder: (_, index) => MyAppProductCardHorizontal(item: controller.allItems[index]),
            );

          }),
        ),
      ),
    );
  }
}