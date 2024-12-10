import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/layouts/grid_layout/grid_layout.dart';
import '../../../../../common_widgets/loaders/shimmer/vertical_product_shimmer.dart';
import '../../../../../common_widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common_widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/product_controller.dart';
import '../../all_products/all_products.dart';

class MyAppHomeBody extends StatelessWidget {
  const MyAppHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final productController = Get.put(ProductController());
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
      child: Column(
        children: [

          /// -- Heading of Popular Products
          MyAppSectionHeading(
              title: 'Popular Products', textColor: dark ? Colors.white : Colors.black,
              onPressed: ()=> Get.to(()=> AllProductsScreen(title: 'Popular Products',
                futureMethod: productController.fetchAllProducts(),
              ))),
          SizedBox(height: MyAppSizes.spaceBtwItems),

          /// -- Popular Product in Grid Layout
          Obx((){
            if (productController.isLoading.value) return const MyAppVerticalProductShimmer();
            if (productController.featuredProducts.isEmpty) {
              return Center(
                  child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
            }
              return MyAppGridLayout(itemCount: productController.featuredProducts.length, itemBuilder:(_,index)=> MyAppProductCardVertical(product: productController.featuredProducts[index]));
          } ),
        ],
      ),
    );
  }
}
