import 'package:ar_interior_visualizer/src/features/visualization/controllers/item_controller.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';

class ItemDialogBoxWidget extends StatelessWidget {
  const ItemDialogBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemController());
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return AlertDialog(
      backgroundColor: dark ? MyAppColors.darkSurfaceColor : MyAppColors.lightSurfaceColor,
      title: const Text('Choose Image Source'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Iconsax.camera),
            title: const Text('Capture Image'),
            onTap: () {
              Navigator.of(Get.overlayContext!).pop(); // Close the dialog
              controller.captureImageWithCamera();
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.gallery),
            title: const Text('Choose Gallery'),
            onTap: () {
              Navigator.of(Get.overlayContext!).pop(); // Close the dialog
              controller.pickImageFromGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Cancel'),
            onTap: () => Navigator.of(Get.overlayContext!).pop(),
          ),
        ],
      ),
    );
  }
}

