import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class MyAppHorizontalProductShimmer extends StatelessWidget {
  const MyAppHorizontalProductShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: MyAppSizes.spaceBtwSections),
      itemBuilder: (_, __) => const SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image
            MyAppShimmerEffect(width: 100, height: 100),
            SizedBox(width: MyAppSizes.spaceBtwItems),

            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MyAppSizes.defaultSpace),
                MyAppShimmerEffect(width: 150, height: 12),
                SizedBox(height: MyAppSizes.spaceBtwItems / 2),
                MyAppShimmerEffect(width: 100, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
