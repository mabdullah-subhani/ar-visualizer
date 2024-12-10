import 'dart:typed_data';

import 'package:ar_interior_visualizer/src/features/visualization/controllers/item_controller.dart';
import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common_widgets/appbar/appbar.dart';
import '../../../../common_widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';

class AddNewItemScreen extends StatelessWidget {
  const  AddNewItemScreen({super.key, this.imageFileUint8List});

  final Uint8List? imageFileUint8List;
  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final controller = Get.put(ItemController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Main Large Image
            MyAppCurvedEdgeWidget(
              child: Container(color: dark ? MyAppColors.darkContainerColor : MyAppColors.lightContainerColor,
                  child: Stack(
                    children: [
                      /// Main Large Image without Background
                      SizedBox(
                        height: 360,
                        child: Center(
                          child: imageFileUint8List != null
                              ? Image.memory(imageFileUint8List!)
                              : Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 80,
                          ),
                        ),
                      ),

                      /// App Bar
                      MyAppBar(
                        showBackArrow: true,
                        colorMode: true,
                      )
                    ],
                  )),
            ),

            Form(
              key: controller.itemFormKey,
              child: Padding(
                padding: const EdgeInsets.only(right: MyAppSizes.defaultSpace,left: MyAppSizes.defaultSpace),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please provide the following information about your product. This information will be displayed on the product detail screen',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: MyAppSizes.spaceBtwSections),

                    /// Title
                    TextFormField(
                      controller: controller.title,
                      validator: (value) => MyAppValidator.validateEmptyText('Title', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.subtitle),
                        labelText: 'Title',
                        hintText: 'Enter item title',
                      ),
                    ),
                    const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                    /// Category
                    TextFormField(
                      controller: controller.category,
                      validator: (value) => MyAppValidator.validateEmptyText('Category', value),

                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.category),
                        labelText: 'Category',
                        hintText: 'Enter item category (Sofa,Bed,i.e.)',
                      ),
                    ),
                    const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                    /// Description
                    TextFormField(
                      controller: controller.description,
                      validator: (value) => MyAppValidator.validateEmptyText('Description', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: 'Description',
                        hintText: 'Enter item description',
                      ),
                    ),
                    const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                    const SizedBox(height: MyAppSizes.spaceBtwItems),

                    /// Upload Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()=> controller.upload(imageFileUint8List),
                        child: Text(
                          MyAppTexts.upload.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
