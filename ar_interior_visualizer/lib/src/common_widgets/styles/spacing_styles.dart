import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class MyAppSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MyAppSizes.appBarHeight,
    left: MyAppSizes.defaultSpace,
    bottom: MyAppSizes.defaultSpace,
    right: MyAppSizes.defaultSpace,
  );
}