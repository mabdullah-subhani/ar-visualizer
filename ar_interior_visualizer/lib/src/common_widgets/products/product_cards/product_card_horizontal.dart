import 'package:ar_interior_visualizer/src/features/visualization/controllers/change_item_details_controller.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/my_products/change_item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/visualization/models/item_model.dart';
import '../../../features/visualization/screens/product_details/my_product_details.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images_widgets/rounded_image/rounded_image.dart';
import '../../styles/shadows.dart';
import '../../texts/product_title_text.dart';

class MyAppProductCardHorizontal extends StatelessWidget {
  const MyAppProductCardHorizontal({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final controller = Get.put(UpdateItemDetailsController(docId: item.docId.toString()));

    return GestureDetector(
      onTap: ()=> Get.to(()=>MyProductDetailScreen(item: item,)),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MyAppShadowStyle.horizontalProductShadow],
          borderRadius: BorderRadius.circular(MyAppSizes.productImageRadius),
          color: dark ? MyAppColors.darkBorderColor : MyAppColors.lightBorderColor,
        ),
        child: Row(
          children: [
            /// Thumbnail
            MyAppRoundedContainer(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(MyAppSizes.sm),
              backgroundColor: dark ? MyAppColors.darkContainerColor : MyAppColors.lightContainerColor,
              child: MyAppRoundedImage(imageUrl: item.image,height: 100, applyImageRadius: true,isNetworkImage: true,),
            ),

            /// -- Details
            Expanded(
              child: Container(
                padding:  EdgeInsets.only(left: MyAppSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MyAppSizes.defaultSpace),
                    /// Title
                    MyAppProductTitleText(title: item.title,maxLines: 2, smallSize: true),
                    SizedBox(height: MyAppSizes.sm),
                    /// Category
                    Text(item.category, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ),

            /// Buttons
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Edit Button
                  Container(
                    decoration: BoxDecoration(
                      color: dark ? MyAppColors.darkPrimaryColor : MyAppColors.lightPrimaryColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(MyAppSizes.productImageRadius),
                        bottomLeft: Radius.circular(MyAppSizes.cardRadiusMd),
                      ),),
                    child: SizedBox(
                        width: MyAppSizes.iconLg*1.2,
                        height: MyAppSizes.iconLg*1.2,
                        child: Center(child:
                        IconButton(onPressed: ()=> Get.to(()=>const ChangeItemDetailsScreen(), arguments: {'docId': item.docId}),icon: const Icon(Icons.edit, color: Colors.white)),
                        ),
                    ),
                  ),

                  /// Delete Button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(MyAppSizes.cardRadiusMd),
                        bottomRight: Radius.circular(MyAppSizes.productImageRadius),
                      ),
                    ),
                    child: SizedBox(
                        width: MyAppSizes.iconLg*1.2,
                        height: MyAppSizes.iconLg*1.2,
                        child: Center(child: IconButton(onPressed: () => controller.deleteItem(), icon:  const Icon(Icons.delete, color: Colors.white,)))),
                  ),
                ]
            ),

          ],
        ),
      ),
    );
  }
}
