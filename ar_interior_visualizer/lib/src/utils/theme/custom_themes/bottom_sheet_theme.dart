import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MyAppBottomSheetTheme {
  MyAppBottomSheetTheme._();

  static final lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: MyAppColors.lightSurfaceColor,
    modalBackgroundColor: MyAppColors.lightSurfaceColor,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static final darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: MyAppColors.darkSurfaceColor,
    modalBackgroundColor: MyAppColors.darkSurfaceColor,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}