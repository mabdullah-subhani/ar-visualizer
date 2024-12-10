import 'package:ar_interior_visualizer/src/features/visualization/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common_widgets/layouts/grid_layout/grid_layout.dart';
import '../../../../../common_widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/all_products_controller.dart';

class MyAppSortableProducts extends StatelessWidget {
  const MyAppSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel>products;
  @override
  Widget build(BuildContext context) {
    /// Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [

        /// -- Dropdown
        Obx(
          ()=> DropdownButtonFormField(

            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort),),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              print("Selected value: $value"); // Debug print

              if (value != null) {
                controller.sortProducts(value); // Call sorting function
                controller.selectedSortOption.value = value; // Update selected option
              }
            },
            items: ['Name', 'Newest', 'Sofa', 'Bed', 'Table', 'Chair', 'Lamp']
                .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
          ),
        ),

        SizedBox(height: MyAppSizes.spaceBtwSections),
        /// -- Favourite Products Grid
        Obx(
          ()=> MyAppGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => MyAppProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
