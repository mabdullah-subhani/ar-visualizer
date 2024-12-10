import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class MyAppTheme {
  MyAppTheme._(); //To avoid creating instances

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    scaffoldBackgroundColor:  MyAppColors.lightBackgroundColor,

    textTheme: MyAppTextTheme.lightTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyAppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyAppBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.lightInputDecorationTheme,
  ); // ThemeData

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    scaffoldBackgroundColor:  MyAppColors.darkBackgroundColor,


    textTheme: MyAppTextTheme.darkTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    checkboxTheme: MyAppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MyAppBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.darkInputDecorationTheme,

  ); // ThemeData
}
