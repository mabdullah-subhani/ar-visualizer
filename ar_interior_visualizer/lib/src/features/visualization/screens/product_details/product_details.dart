import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/common_widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ar_interior_visualizer/src/common_widgets/products/favourite_icon/favourite_icon.dart';
import 'package:ar_interior_visualizer/src/features/visualization/models/product_model.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common_widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;
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
                          child:Center(
                                child:
                                // Image(image: AssetImage(MyAppImages.forgotPassOTPImage)),

                                ModelViewer(
                                  src: product.image,
                                  ar: true,
                                  autoPlay: false,
                                  autoRotate: false,
                                ),
                              ),
                        ),
                      ),

                      /// App Bar
                      MyAppBar(
                        showBackArrow: true,
                        colorMode: true,
                        actions: [
                          /// Favourite Icon Button
                         MyAppFavouriteIcon(productId: product.id,)
                        ],
                      )
                    ],
                  )),
            ),

            /// Heading of product
            Padding(
              padding: const EdgeInsets.only(right: MyAppSizes.defaultSpace, left: MyAppSizes.defaultSpace,bottom: MyAppSizes.defaultSpace,),

              child: Column(children: [

                /// Rating & Share
                RatingAndShare(),

                /// Heading of product
                 MyAppSectionHeading(
                    title: product.title, showActionButton: false),
                SizedBox(height: MyAppSizes.spaceBtwItems),

                /// Sub Heading
                Row(
                  children: [
                    Text(
                      'Category', overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.bodyLarge,),
                    SizedBox(width: MyAppSizes.spaceBtwItems),
                    Text(
                      product.categoryName,
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
                  product.description ?? '',
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
                const SizedBox(height: MyAppSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: MyAppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyAppSectionHeading(
                      title: 'Reviews (199)',
                      showActionButton: false,
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

