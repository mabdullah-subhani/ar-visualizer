import 'package:ar_interior_visualizer/src/common_widgets/images_widgets/circular_image/circular_image.dart';
import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyAppVerticalImageText extends StatelessWidget {
  const MyAppVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.boxFit,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final BoxFit? boxFit;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: MyAppSizes.spaceBtwItems),
        child: Column(
          children: [
            MyAppCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: MyAppSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? MyAppColors.light : MyAppColors.dark,
            ),
            const SizedBox(height: MyAppSizes.spaceBtwItems / 2),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
