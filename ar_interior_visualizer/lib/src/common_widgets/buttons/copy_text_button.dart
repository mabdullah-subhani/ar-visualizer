import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants/colors.dart';

class MyAppCopyTextButton extends StatelessWidget {
  final String textToCopy;
  const MyAppCopyTextButton({
    super.key,
    required this.textToCopy,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: () => copyText(context), // Use the same function for the button
    );
  }

  /// This method can also be triggered externally
  Future<void> copyText(BuildContext context) async {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    await Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: dark ? MyAppColors.lightSurfaceColor : MyAppColors.darkSurfaceColor,
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
