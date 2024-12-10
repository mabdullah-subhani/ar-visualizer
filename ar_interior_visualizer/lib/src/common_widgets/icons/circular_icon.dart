import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
class MyAppCircularIcon extends StatelessWidget {
  /// A custom Circular Icon widget with a background color.

  /// Properties are:
  /// - Container: [width], [height], & [backgroundColor]
  /// - Icon: [size], [color] & [onPressed]

  const MyAppCircularIcon ({
    super.key,
    required this.icon,
    this.width=40,
    this.height=40,
    this.size = MyAppSizes.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : MyAppHelperFunctions.isDarkMode(context)
            ? Colors.black.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size))),
    );
  }
}