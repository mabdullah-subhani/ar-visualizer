import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyAppTextFormFieldTheme {
  MyAppTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =  InputDecorationTheme(
    errorMaxLines: 3,
    suffixIconColor: MyAppColors.lightPrimaryColor,
    prefixIconColor: MyAppColors.lightPrimaryColor,
    labelStyle:  const TextStyle().copyWith(fontSize: 14, color: MyAppColors.lightPrimaryColor),
    hintStyle:  const TextStyle().copyWith(fontSize: 14, color: MyAppColors.lightPrimaryColor),
    floatingLabelStyle:   const TextStyle().copyWith(color: MyAppColors.lightPrimaryColor.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color:  MyAppColors.lightBorderColor)
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color:  MyAppColors.lightBorderColor)
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.black12)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.orange)
    ),

  );

  static InputDecorationTheme darkInputDecorationTheme =  InputDecorationTheme(
    errorMaxLines: 3,
    suffixIconColor: MyAppColors.darkPrimaryColor,
    prefixIconColor: MyAppColors.darkPrimaryColor,
    labelStyle:  const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle:  const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    floatingLabelStyle:   const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14.0),
        borderSide: const BorderSide(width: 1, color: MyAppColors.darkBorderColor)
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color:  MyAppColors.darkBorderColor)
  ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.black12)
  ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.red)
  ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(width: 1, color: Colors.orange)
  ),
  );
}
