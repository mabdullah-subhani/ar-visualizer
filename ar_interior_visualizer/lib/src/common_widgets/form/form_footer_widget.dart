import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class FormFooterWidget extends StatelessWidget {
  const FormFooterWidget({
    super.key,
    required this.heightBetween,
    required this.image,
    required this.buttonText,
    required this.firstText,
    required this.secondText,
    required this.onTap, this.onPressed,
  });

  final double heightBetween;
  final String image, buttonText, firstText, secondText;
  final VoidCallback? onTap , onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: MyAppSizes.spaceBtwSections),
        /// Footer Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: Image(
              image: AssetImage(image),
              width: 20.0,
            ),
            onPressed: onPressed,
            label: Text(buttonText),
          ),
        ),
        /// Footer Text Button
        TextButton(
          onPressed: onTap,
          child: Text.rich(
            TextSpan(
              text: firstText,
              style: Theme.of(context).textTheme.labelLarge,
              children: [
                TextSpan(
                  text: secondText,
                  style: TextStyle(color: dark ? MyAppColors.darkSecondaryColor : MyAppColors.lightSecondaryColor,),
                ), // TextSpan
              ],
            ), // TextSpan
          ), // Text.rich
        ),
      ], // Column children
    );
  }
}
