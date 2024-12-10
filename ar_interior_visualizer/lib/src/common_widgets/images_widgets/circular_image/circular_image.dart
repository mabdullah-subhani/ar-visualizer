import 'package:ar_interior_visualizer/src/common_widgets/loaders/shimmer/shimmer_effect.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyAppCircularImage extends StatelessWidget {
  const MyAppCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = MyAppSizes.xxs,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (MyAppHelperFunctions.isDarkMode(context)
                ? Colors.white
                : Colors.black),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
borderRadius: BorderRadius.circular(100),
       child  : Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, error) => const MyAppShimmerEffect(width: 180, height: 180),
                )
              : Image(
                  fit: fit,
                  image:  AssetImage(image),
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
