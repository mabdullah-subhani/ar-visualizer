import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class MyAppAnimationLoaderWidget extends StatelessWidget {
  const MyAppAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              width: MediaQuery.of(context).size.width * 0.8, // Display Lottie animation
              image: AssetImage(animation)),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? Colors.white : Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(
                    backgroundColor:
                    dark ? MyAppColors.darkPrimaryColor : MyAppColors.lightPrimaryColor),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                ),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }

}
