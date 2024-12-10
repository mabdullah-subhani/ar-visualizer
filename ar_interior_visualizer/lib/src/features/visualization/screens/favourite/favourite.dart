import 'package:ar_interior_visualizer/src/features/visualization/controllers/product/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/icons/circular_icon.dart';
import '../../../../common_widgets/layouts/grid_layout/grid_layout.dart';
import '../../../../common_widgets/loaders/animation_loader.dart';
import '../../../../common_widgets/loaders/shimmer/vertical_product_shimmer.dart';
import '../../../../common_widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Favourite', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          MyAppCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Favourite Products Grid
              Obx(
                ()=> FutureBuilder(
                future: controller.favoriteProducts(),
                    builder: (context, snapshot) {

                      /// Nothing Found Widget
                      final emptyWidget = MyAppAnimationLoaderWidget(
                        text: 'Whoops! Wishlist is Empty.',
                        animation: MyAppImages.wishlistAnimation,
                        showAction: true,
                        actionText: "Let's add some",
                        onActionPressed: () => Get.to(() => const HomeScreen()),
                      );

                      var loader = MyAppVerticalProductShimmer(itemCount:  6);
                      final widget = MyAppCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                      if (widget != null) return widget;
                      final products = snapshot.data!;
                    return MyAppGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>  MyAppProductCardVertical(product: products[index],),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );  }
}
