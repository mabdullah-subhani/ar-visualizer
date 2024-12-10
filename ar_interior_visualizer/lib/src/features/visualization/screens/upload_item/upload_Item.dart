import 'package:ar_interior_visualizer/src/features/visualization/screens/upload_item/add_new_item.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/upload_item/widgets/item_dialogbox_widget.dart';
import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';
import 'package:ar_interior_visualizer/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/icons/circular_icon.dart';
import '../../../../utils/constants/sizes.dart';


class UploadItemScreen extends StatelessWidget {
  const UploadItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Upload Items', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        colorMode: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers the content
          crossAxisAlignment: CrossAxisAlignment.center, // Aligns the content in the center
          children: [
            // Displaying the image
            Image.asset(dark ? MyAppImages.darkConstruct2DModel : MyAppImages.lightConstruct2DModel),
            SizedBox(height: MyAppSizes.spaceBtwItems), 
            // Text to explain the action
            Text(
              'Please take an image to use as the basis for creating your 2D model.',
              textAlign: TextAlign.center, 
              style:Theme.of(context).textTheme.labelMedium,  
            ),
            SizedBox(height: MyAppSizes.spaceBtwItems),
          ],
        ),
      ),
      
      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(
          const ItemDialogBoxWidget(),
          barrierDismissible: true, // Allows dismissing by tapping outside
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

}
