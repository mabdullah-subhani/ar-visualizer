import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class SearchCenterSpace extends StatelessWidget {
  final Widget child; // Child widget to display

  const SearchCenterSpace({
    super.key,
    required this.child, // Required parameter to pass the child widget
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MyAppHelperFunctions.screenHeight() / 1.5, // Ensures full-height
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Fill the entire screen with background if needed
          Positioned.fill(
            child: Container(
            ),
          ),
          // Centered Child Widget (passed as child)
          Center(
            child: child, // Use the widget passed as the child
          ),
        ],
      ),
    );
  }
}
