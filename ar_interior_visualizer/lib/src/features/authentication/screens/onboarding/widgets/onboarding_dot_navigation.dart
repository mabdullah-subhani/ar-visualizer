import 'package:ar_interior_visualizer/src/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;
    return Positioned(
      bottom: MyAppDeviceUtils.getBottomNavigationBarHeight() + 150,
      // left: MyAppSizes.defaultSpace,
      left: MyAppHelperFunctions.screenWidth() * 0.37,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
            activeDotColor: dark? MyAppColors.darkSecondaryColor : MyAppColors.lightSecondaryColor,dotHeight: 6.0),
      ),
    );
  }
}
