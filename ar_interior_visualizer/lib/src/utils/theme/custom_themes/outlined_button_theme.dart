import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

// Light & Dark Outlined Button Themes
class MyAppOutlinedButtonTheme {
  MyAppOutlinedButtonTheme._(); //To avoid creating instances

  // Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: MyAppColors.lightPrimaryColor,
        side: const BorderSide(color: MyAppColors.lightPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: MyAppSizes.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)
    ),
  );

  // Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: MyAppColors.darkPrimaryColor,
        side: const BorderSide(color: MyAppColors.darkPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: MyAppSizes.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)
    ),

  );
}
