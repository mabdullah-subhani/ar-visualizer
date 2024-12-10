import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class MyAppGridLayout extends StatelessWidget {
  const MyAppGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 250,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent!,
        mainAxisSpacing: MyAppSizes.gridViewSpacing,
        crossAxisSpacing: MyAppSizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}