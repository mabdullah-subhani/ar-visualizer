import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyAppSearchContainer extends StatelessWidget {
  const MyAppSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MyAppSizes.defaultSpace),
        child: Container(
          width: MyAppDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(MyAppSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? Colors.black54
                : Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(MyAppSizes.cardRadiusLg),
            border: showBorder
                ? Border.all(color: dark ? Colors.white : Colors.black54)
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, color:dark ? Colors.white : Colors.black54),
              const SizedBox(width: MyAppSizes.spaceBtwItems),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.apply(color: dark ? Colors.white : Colors.black54)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
