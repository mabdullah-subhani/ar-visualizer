import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../curved_edges/curved_edges_widget.dart';

import 'dart:async';

class PrimaryHeaderContainer extends StatefulWidget {
  const PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  _PrimaryHeaderContainerState createState() => _PrimaryHeaderContainerState();
}

class _PrimaryHeaderContainerState extends State<PrimaryHeaderContainer> {
  bool _isSwapped = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Set the timer to swap colors every 2 seconds for a smoother transition
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _isSwapped = !_isSwapped;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = MyAppHelperFunctions.isDarkMode(context);
    final gradientColors = darkMode
        ? _isSwapped
        ? [MyAppColors.darkPrimaryColor, MyAppColors.darkSecondaryColor]
        : [MyAppColors.darkSecondaryColor, MyAppColors.darkPrimaryColor]
        : _isSwapped
        ? [MyAppColors.lightSecondaryColor, MyAppColors.lightPrimaryColor]
        : [MyAppColors.lightPrimaryColor, MyAppColors.lightSecondaryColor];

    return MyAppCurvedEdgeWidget(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2), // Slower transition for smoother swapping
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            stops: const [0.09, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            widget.child,
          ],
        ),
      ),
    );
  }
}
