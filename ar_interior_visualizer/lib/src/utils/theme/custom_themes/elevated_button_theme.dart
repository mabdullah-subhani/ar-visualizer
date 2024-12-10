import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

// Light & Dark Elevated Button Themes
class MyAppElevatedButtonTheme {
  MyAppElevatedButtonTheme._(); //To avoid creating instances

  // Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: MyAppColors.lightPrimaryColor,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: MyAppColors.lightPrimaryColor),
      padding: const EdgeInsets.symmetric(vertical: MyAppSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)

    ),
  );

  // Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: MyAppColors.darkPrimaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: const BorderSide(color: MyAppColors.darkPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: MyAppSizes.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)
    ),
  );
}
