import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: MyAppSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              MyAppShimmerEffect(width: 55, height: 55, radius: 55),

              SizedBox(height: MyAppSizes.spaceBtwItems / 2),

              // Text
              MyAppShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}