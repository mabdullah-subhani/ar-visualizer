import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/common_widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/ar_view/virtual_ar_view.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../common_widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/item_model.dart';

class MyProductDetailScreen extends StatelessWidget {
  const MyProductDetailScreen({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppCurvedEdgeWidget(
              child: Container(
                  color: dark
                      ? MyAppColors.darkContainerColor
                      : MyAppColors.lightContainerColor,
                  child: Stack(
                    children: [
                      /// Main Large Image
                      SizedBox(
                        height: 400,
                        child: Padding(
                          padding:
                          EdgeInsets.all(MyAppSizes.productImageRadius * 2),
                          child: Center(
                              child:
                              Image.network(item.image)
                          ),
                        ),
                      ),

                      /// App Bar
                      MyAppBar(
                        showBackArrow: true,
                        colorMode: true,
                      )
                    ],
                  )),
            ),

            /// Heading of product
            Padding(
              padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
              child: Column(children: [
                /// Heading of product
                 MyAppSectionHeading(
                    title: item.title, showActionButton: false),
                SizedBox(height: MyAppSizes.spaceBtwItems),

                /// Sub Heading
                Row(
                  children: [
                    Text(
                      'Category',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: MyAppSizes.spaceBtwItems),
                    Text(
                      item.category,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                SizedBox(height: MyAppSizes.spaceBtwSections),

                /// Description
                const MyAppSectionHeading(
                    title: 'Description', showActionButton: false),
                SizedBox(height: MyAppSizes.spaceBtwItems),
                 ReadMoreText(
                  item.description,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Less',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: MyAppColors.lightSecondaryColor),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: MyAppColors.lightSecondaryColor),
                ),

                SizedBox(height: MyAppSizes.spaceBtwSections),

                /// AR View Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.to(()=>
                        VirtualARViewScreen(item: item,)
                        // VirtualARViewScreen(item: item,)
                    ),
                      icon: Icon(Iconsax.video, color: Colors.white),
                      label: const Text('\tTry Virtually (AR View)'),),)
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
