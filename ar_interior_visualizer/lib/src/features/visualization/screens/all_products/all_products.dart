import 'package:ar_interior_visualizer/src/features/visualization/screens/all_products/widgets/sortable_products.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/appbar/appbar.dart';

import '../../../../common_widgets/loaders/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/all_products_controller.dart';
import '../../models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    /// Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Popular Products',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        colorMode: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                /// Check the state of the FutureBuilder snapshot
                const loader = MyAppVerticalProductShimmer();

                final widget = MyAppCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                /// Return appropriate widget based on snapshot state
                if (widget != null) return widget;
                // Products found!
                final products = snapshot.data!;
                return MyAppSortableProducts(products: products);
              }),
        ),
      ),
    );
  }
}
