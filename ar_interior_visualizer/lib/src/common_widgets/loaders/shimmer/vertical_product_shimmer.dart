import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout/grid_layout.dart';

class MyAppVerticalProductShimmer extends StatelessWidget {
  const MyAppVerticalProductShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MyAppGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            MyAppShimmerEffect(width: 180, height: 180),
            SizedBox(height: MyAppSizes.spaceBtwItems),

            // Text
            MyAppShimmerEffect(width: 160, height: 15),
            SizedBox(height: MyAppSizes.spaceBtwItems / 2),
            MyAppShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}