
import 'package:ar_interior_visualizer/src/features/personalization/screens/settings/settings.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/favourite/favourite.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/my_products/my_products.dart';
import 'package:ar_interior_visualizer/src/utils/constants/colors.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/features/visualization/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: darkMode ? MyAppColors.darkSurfaceColor : MyAppColors.lightSurfaceColor,
          indicatorColor: darkMode ? MyAppColors.darkPrimaryColor : MyAppColors.lightPrimaryColor,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations:  [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shop),
              label: 'My Products',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value])
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const MyProductsScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  void navigateToIndex(int index) {
    selectedIndex.value = index;
  }
}
