import 'package:ar_interior_visualizer/src/common_widgets/buttons/copy_text_button.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/changing/change_name.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/changing/change_phoneNo.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/changing/change_username.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/images_widgets/circular_image/circular_image.dart';
import '../../../../common_widgets/loaders/shimmer/shimmer_effect.dart';
import '../../../../common_widgets/texts/section_heading.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: MyAppBar(showBackArrow: true, colorMode: true, title: Text(controller.user.value.fullName)),

      /// -- Body --
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  /// Profile Picture
                  Obx(
                    (){
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : MyAppImages.defaultUserProfile;
                      return controller.imageUploading.value
                        ? const MyAppShimmerEffect(width: 80, height: 80, radius: 80,)
                        : MyAppCircularImage(image: image, width: 80, height: 80,fit: BoxFit.cover, isNetworkImage: networkImage.isNotEmpty,);}
                  ),
                  TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                ],
              ),
            ),

            /// Details
            const SizedBox(height: MyAppSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Heading Profile Information
            const MyAppSectionHeading(
                title: 'Profile Information', showActionButton: false),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Profile Information Menu
            MyAppProfileMenu(
                title: 'Name', value: controller.user.value.fullName, onPressed: ()=> Get.off(()=>const ChangeNameScreen())),
            MyAppProfileMenu(
                title: 'Username',
                value: controller.user.value.userName,
                onPressed: ()=> Get.off(()=>const ChangeUsernameScreen())),

            const SizedBox(height: MyAppSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Heading Personal Information
            const MyAppSectionHeading(
                title: 'Personal Information', showActionButton: false),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Personal Information Menu
            MyAppProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () => MyAppCopyTextButton(textToCopy: controller.user.value.id).copyText(context),
            ),
            MyAppProfileMenu(
                title: 'Email',
                value: controller.user.value.email,
                icon: Iconsax.copy,
              onPressed: () => MyAppCopyTextButton(textToCopy: controller.user.value.email).copyText(context),
            ),
            MyAppProfileMenu(
                title: 'Phone No', value: controller.user.value.phoneNo, onPressed: ()=> Get.off(()=>const ChangePhoneNoScreen())),
            MyAppProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
            MyAppProfileMenu(
                title: 'Date of Birth',
                value: '25 Dec, 2001',
                onPressed: () {}),

            const Divider(),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Close Account Button
            Center(
              child: TextButton(
                onPressed: () => controller.deleteAccountWarningPopup(),
                child: const Text('Delete Account',
                    style: TextStyle(color: Colors.red)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
