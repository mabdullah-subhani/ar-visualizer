import 'package:ar_interior_visualizer/src/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/theme/custom_themes/decoration_box_theme.dart';

class ForgotPassBtnWidget extends StatelessWidget {
  const ForgotPassBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData btnIcon;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 105.0,
        decoration: MyAppDecorationBoxTheme.getDecoration(context),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 9.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(btnIcon, size: 65.0, color: Colors.white),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        title,
                        style: dark
                            ? MyAppTextTheme.darkTheme.titleLarge
                            : MyAppTextTheme.darkTheme.titleLarge,
                      ),
                      Text(
                        subtitle,
                        style: dark
                            ? MyAppTextTheme.darkTheme.bodyMedium
                            : MyAppTextTheme.darkTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
