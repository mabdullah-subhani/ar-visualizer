import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common_widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common_widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common_widgets/list_tiles/user_profile_tile.dart';
import '../../../../common_widgets/switch/switch.dart';
import '../../../../common_widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/user_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>(); // Access ThemeController
    return Obx(
      (){
        final isDarkMode = themeController.isDarkMode.value;

        return Scaffold(
          backgroundColor: isDarkMode ? MyAppColors.darkBackgroundColor : MyAppColors.lightBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                PrimaryHeaderContainer(
                  child: Column(
                    children: [
                      /// -- AppBar --
                      MyAppBar(
                        title: Text(
                          'Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.apply(color: Colors.white),
                        ),
                      ),

                      /// -- User Profile Card --
                      const MyAppUserProfileTile(),
                      const SizedBox(height: MyAppSizes.spaceBtwSections),


                      /// -- Heading --
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
                  child: Column(
                    children: [
                      // Account Settings
                      const MyAppSectionHeading(title: 'Account Settings', showActionButton: false),
                      const SizedBox(height: MyAppSizes.spaceBtwItems),
                      const MyAppSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address'),
                      const MyAppSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove products and move to checkout'),
                      const MyAppSettingsMenuTile(icon: Iconsax.box_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders'),
                      const MyAppSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account'),
                      const MyAppSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons'),
                      const MyAppSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message'),
                      const MyAppSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts'),

                      // App Settings
                      const SizedBox(height: MyAppSizes.spaceBtwSections),
                      const MyAppSectionHeading(title: 'App Settings', showActionButton: false),
                      const SizedBox(height: MyAppSizes.spaceBtwItems),
                      const MyAppSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload data to your Cloud Firebase'),
                      MyAppSettingsMenuTile(
                        icon: themeController.isDarkMode.value
                            ? Icons.wb_sunny_outlined
                            : Iconsax.moon,
                        title: isDarkMode ? 'Disable Dark Mode' : 'Enable Dark Mode',
                        subTitle: isDarkMode
                            ? 'Switch to light mode for a brighter theme.'
                            : 'Switch to dark mode for a darker theme.',
                        trailing: MyAppSwitch(
                          isDarkMode: isDarkMode,
                          onChanged: (value) => themeController.toggleTheme(),
                        ),
                      ),
                      MyAppSettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is safe for all ages', trailing: Switch(value: false, onChanged: (value) {})),
                      MyAppSettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be seen', trailing: Switch(value: false, onChanged: (value) {})),

                      /// -- Logout Button --
                      const SizedBox(height: MyAppSizes.spaceBtwSections),
                      SizedBox(
                        width: MyAppSizes.buttonWidth,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              UserController.instance.logoutAccountWarningPopup(),
                          // CategoryRepository.instance.uploadDummyData(MyAppDummyData.categories),
                          // ProductRepository.instance.uploadDummyData(MyAppDummyData.products),
                          icon: Icon(Iconsax.logout4, color: Colors.white),
                          label: const Text('Logout'),
                        ),
                      ),
                      const SizedBox(height: MyAppSizes.spaceBtwSections * 2.5),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
