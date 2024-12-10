import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/images_strings.dart';
import '../images_widgets/circular_image/circular_image.dart';
import '../loaders/shimmer/shimmer_effect.dart';

class MyAppUserProfileTile extends StatelessWidget {
  const MyAppUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty
            ? networkImage
            : MyAppImages.defaultUserProfile;
        return controller.imageUploading.value
            ? const MyAppShimmerEffect(
                width: 50,
                height: 50,
                radius: 50,
              )
            : MyAppCircularImage(
                image: image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                isNetworkImage: networkImage.isNotEmpty,
              );
      }),

      title: Obx(() {
        // Trigger fetchUserItems when data is updated
        if (controller.isDataUpdated.value) {controller.fetchUserRecord();}
        return Text(controller.user.value.fullName,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white));
      }),

      subtitle: Text(controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Iconsax.edit, color: Colors.white),
      ),
    );
  }
}
