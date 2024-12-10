import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: MyAppSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(
          children: [
            // Image
            Image(
                image: AssetImage(image),
                width: MyAppHelperFunctions.screenWidth() * 0.6),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Title & SubTitle
            Text(
                title,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: MyAppSizes.spaceBtwItems),
            Text(
                subTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(MyAppTexts.continueButton)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
