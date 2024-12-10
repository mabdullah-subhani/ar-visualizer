import 'package:ar_interior_visualizer/src/bindings/general_binding.dart';
import 'package:ar_interior_visualizer/src/features/personalization/controllers/theme_controller.dart';
import 'package:ar_interior_visualizer/src/routing/app_page_routes.dart';
import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:ar_interior_visualizer/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController()); // Inject controller
    themeController.initializeTheme(context);
    return GetMaterialApp(
      // themeMode: ThemeMode.system,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      initialBinding: GeneralBindings(),
      getPages: MyAppPageRoutes.pages,
      // transitionDuration: const Duration(microseconds: 500),

      /// Show Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen
      home: const Scaffold(
        backgroundColor: MyAppColors.darkPrimaryColor,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
