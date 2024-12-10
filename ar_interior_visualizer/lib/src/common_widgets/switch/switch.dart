  import 'package:flutter/material.dart';
  import '../../utils/constants/colors.dart'; // Your custom colors file

  class MyAppSwitch extends StatelessWidget {
    final bool isDarkMode;
    final ValueChanged<bool> onChanged; // Use ValueChanged for better semantics

    const MyAppSwitch({
      super.key,
      required this.isDarkMode,
      required this.onChanged,
    });

    @override
    Widget build(BuildContext context) {
      return Switch(
        value: isDarkMode,
        onChanged: onChanged, // Call the provided callback
        activeColor: isDarkMode
            ? MyAppColors.darkSecondaryColor
            : MyAppColors.lightSecondaryColor,
        activeTrackColor: isDarkMode
            ? MyAppColors.darkPrimaryColor
            : MyAppColors.lightPrimaryColor,
        // inactiveThumbColor: Colors.grey,
        // inactiveTrackColor: isDarkMode
        //     ? MyAppColors.darkPrimaryColor
        //     : MyAppColors.lightPrimaryColor,
      );
    }
  }
