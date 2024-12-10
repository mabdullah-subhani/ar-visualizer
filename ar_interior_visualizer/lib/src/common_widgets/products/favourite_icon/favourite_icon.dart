import 'package:ar_interior_visualizer/src/common_widgets/icons/circular_icon.dart';
import 'package:ar_interior_visualizer/src/features/visualization/controllers/product/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyAppFavouriteIcon extends StatelessWidget {
  const MyAppFavouriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => MyAppCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? Colors.red : null,
    onPressed: ()=> controller.toggleFavoriteProduct(productId)));
  }
}
