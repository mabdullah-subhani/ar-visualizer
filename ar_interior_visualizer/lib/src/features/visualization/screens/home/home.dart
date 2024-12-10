import 'package:ar_interior_visualizer/src/common_widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/home/widgets/home_appbar.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/home/widgets/home_categories.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/home/widgets/home_products.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/search/search.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_shapes/containers/search_container.dart';

import '../../../../common_widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark
          ? MyAppColors.darkBackgroundColor
          : MyAppColors.lightBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- MY APP Customize Header With Color Animation --
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- AppBar --
                  const HomeAppBar(),
                  const SizedBox(height: MyAppSizes.spaceBtwSections),

                  /// -- SearchBar --
                  MyAppSearchContainer(text: 'Search',onTap:  ()=> Get.to(()=> SearchScreen()),),
                  const SizedBox(height: MyAppSizes.spaceBtwSections),

                  /// -- Heading & Categories --
                  const Column(
                    children: [
                      Padding(

                          /// -- Heading
                          padding:
                              EdgeInsets.only(left: MyAppSizes.defaultSpace),
                          child: MyAppSectionHeading(
                              title: 'Popular Categories',
                              showActionButton: false,
                              textColor: Colors.white)),
                      SizedBox(height: MyAppSizes.spaceBtwSections / 2),

                      /// -- Categories List --
                      MyAppHomeCategories(),
                      SizedBox(height: MyAppSizes.spaceBtwSections)
                    ],
                  ),
                ],
              ),
            ),

            /// -- Body
            /// -- Heading & Products
            MyAppHomeBody(),
          ],
        ),
      ),
    );
  }
}
