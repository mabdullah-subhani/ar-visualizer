import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/category_shimmer.dart';
import 'package:ar_interior_visualizer/src/features/visualization/controllers/category_controller.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/images_widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../categories.dart';


class MyAppHomeCategories extends StatelessWidget {
  const MyAppHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final categoryController= Get.put(CategoryController());
    return Obx(
      (){
        if(categoryController.isLoading.value) return CategoryShimmer();
        if (categoryController.featuredCategories.isEmpty) {
          return Center(
            child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
        }
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return MyAppVerticalImageText(
                backgroundColor: dark ? MyAppColors.darkSurfaceColor : MyAppColors.lightBackgroundColor,
                image: category.image, title: category.name,boxFit: BoxFit.cover, onTap: () => Get.to(()=>CategoriesScreen(category: category)));
            },
          ),
        );
      }
    );
  }
}
