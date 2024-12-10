import 'package:ar_interior_visualizer/src/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ar_interior_visualizer/src/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: MyAppImages.onBoardingImage1,
                  title: MyAppTexts.onBoardingTitle1,
                  subTitle: MyAppTexts.onBoardingSubTitle1),
              OnBoardingPage(
                  image: MyAppImages.onBoardingImage2,
                  title: MyAppTexts.onBoardingTitle2,
                  subTitle: MyAppTexts.onBoardingSubTitle2),
              OnBoardingPage(
                  image: MyAppImages.onBoardingImage3,
                  title: MyAppTexts.onBoardingTitle3,
                  subTitle: MyAppTexts.onBoardingSubTitle3),
            ],
          ),

          ///  Skip Button
          const OnBoardingSkip(),

          ///  Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Navigator Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}