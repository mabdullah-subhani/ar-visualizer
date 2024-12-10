import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MyAppCheckboxTheme {
  MyAppCheckboxTheme._(); // To avoid creating instances

  // Customizable Light Text Theme
  static var lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
      side: const BorderSide(
        width: 6.0, // Adjust the width to control the size
        color: Colors.black,
      ),),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MyAppColors.lightSecondaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );

  // Customizable Dark Text Theme
  static var darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return MyAppColors.darkSecondaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );
}