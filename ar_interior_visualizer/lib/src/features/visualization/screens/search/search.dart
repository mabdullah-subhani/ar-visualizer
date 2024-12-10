import 'package:ar_interior_visualizer/src/features/visualization/controllers/search_controller.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/search/widgets/search_center_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/layouts/grid_layout/grid_layout.dart';
import '../../../../common_widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchScreenController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        colorMode: true,
        title: Text(
          'Search Products',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: MyAppSizes.defaultSpace, right: MyAppSizes.defaultSpace),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.only(top: MyAppSizes.spaceBtwItems, bottom: MyAppSizes.spaceBtwItems),
                child: TextField(
                  onChanged: (value) {
                    searchController.searchProducts(value.trim());
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for products...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // Search Results
              Obx(() {
                if (searchController.isLoading.value) {
                  // Show a loader while searching
                  return const SearchCenterSpace(child: CircularProgressIndicator());
                }

                if (searchController.searchResults.isEmpty) {
                  // Show a message if no results found
                  return SearchCenterSpace(child: Text(
                    'No results to display',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),);
                }

                // Show the list of products
                return MyAppGridLayout(
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (_, index) => MyAppProductCardVertical(
                    product: searchController.searchResults[index],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
