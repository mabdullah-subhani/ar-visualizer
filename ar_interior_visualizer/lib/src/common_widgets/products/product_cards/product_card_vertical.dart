import 'package:ar_interior_visualizer/src/common_widgets/images_widgets/rounded_image/rounded_image.dart';
import 'package:ar_interior_visualizer/src/features/visualization/models/product_model.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/product_details/product_details.dart';
import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../testing.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/circular_icon.dart';
import '../../styles/shadows.dart';
import '../../texts/product_title_text.dart';
import '../favourite_icon/favourite_icon.dart';

class MyAppProductCardVertical extends StatelessWidget {
  const MyAppProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MyAppShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MyAppSizes.productImageRadius),
          color: dark
              ? MyAppColors.darkBorderColor
              : MyAppColors.lightBorderColor,
        ),
        child: Column(
          children: [
            /// Thumbnail & Favorite Button
            MyAppRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(MyAppSizes.sm),
              backgroundColor: dark
                  ? MyAppColors.darkContainerColor
                  : MyAppColors.lightContainerColor,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  Center(
                    child: MyAppRoundedImage(
                      imageUrl: product.thumbnail,
                      height: 180,
                      width: 180,
                      applyImageRadius: true,
                      isNetworkImage: true, // Assuming thumbnails are network images
                    ),
                  ),

                  /// -- Favorite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: MyAppFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            SizedBox(height: MyAppSizes.spaceBtwItems / 2),

            /// -- Details
            Padding(
              padding: EdgeInsets.only(left: MyAppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyAppProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  SizedBox(height: MyAppSizes.xsm),
                  Row(
                    children: [
                      Text(
                        product.categoryName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


