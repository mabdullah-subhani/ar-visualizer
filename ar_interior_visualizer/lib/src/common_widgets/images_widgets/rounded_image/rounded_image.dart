import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class MyAppRoundedImage extends StatelessWidget {
  const MyAppRoundedImage({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.onPressed,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.backgroundColor = MyAppColors.light,
    this.border,
    this.isNetworkImage = true,
    this.borderRadius = MyAppSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Image.asset(
            imageUrl,
            fit: fit,
            // No error handling here
          ),
        ),
      ),
    );
  }
}
