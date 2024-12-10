import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class MyAppShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: MyAppColors.darkSurfaceColor.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  ); // BoxShadow

  static final horizontalProductShadow = BoxShadow(
    color: MyAppColors.darkSurfaceColor.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(6, 2),
  ); // BoxShadow
}