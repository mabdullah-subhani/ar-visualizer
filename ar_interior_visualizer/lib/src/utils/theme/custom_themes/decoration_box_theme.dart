import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyAppDecorationBoxTheme{

  MyAppDecorationBoxTheme._();

  static BoxDecoration lightDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: MyAppColors.lightPrimaryColor,
// Light background
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade400,
        blurRadius: 10.0,
        offset: const Offset(0, 4),
      ),

    ],
  );

  // Dark Mode Box Decoration
  static BoxDecoration darkDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: MyAppColors.darkPrimaryColor, // Dark background
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.6),
        blurRadius: 10.0,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration getDecoration(BuildContext context) {
    return Theme
        .of(context)
        .brightness == Brightness.dark
        ? darkDecoration
        : lightDecoration;
  }
}