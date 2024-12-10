import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class MyAppSettingsMenuTile extends StatelessWidget {
  const MyAppSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: dark ? MyAppColors.darkPrimaryColor : MyAppColors.lightPrimaryColor,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
