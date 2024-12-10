import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/features/visualization/controllers/change_item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
class ChangeItemDetailsScreen extends StatefulWidget {
  const ChangeItemDetailsScreen({super.key});

  @override
  State<ChangeItemDetailsScreen> createState() => _ChangeItemDetailsScreenState();
}

class _ChangeItemDetailsScreenState extends State<ChangeItemDetailsScreen> {
  late UpdateItemDetailsController controller;

  @override
  void initState() {
    super.initState();

    // Retrieve the docId from arguments and initialize the controller
    final String docId = Get.arguments['docId'];
    controller = Get.put(UpdateItemDetailsController(docId: docId));
  }

  @override
  void dispose() {
    // Clean up the controller when the screen is disposed
    Get.delete<UpdateItemDetailsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        colorMode: true,
        title: Text(
          'Change Item Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
          child: Form(
            key: controller.updateItemDetailsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s Update Your Item Details!\nPlease make sure details should be clear...',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),

                // Title Field
                TextFormField(
                  controller: controller.title,
                  validator: (value) => MyAppValidator.validateEmptyText('Title', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.subtitle),
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                // Category Field
                TextFormField(
                  controller: controller.category,
                  validator: (value) => MyAppValidator.validateEmptyText('Category', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    labelText: 'Category',
                  ),
                ),
                const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                // Description Field
                TextFormField(
                  controller: controller.description,
                  validator: (value) => MyAppValidator.validateEmptyText('Description', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Description',
                  ),
                ),

                const SizedBox(height: MyAppSizes.spaceBtwItems),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.updateItemDetails(),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
