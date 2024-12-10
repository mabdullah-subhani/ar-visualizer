import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/features/personalization/controllers/update_controllers/update_username_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class ChangeUsernameScreen extends StatelessWidget {
  const ChangeUsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserNameController());
    return Scaffold(
      // ... AppBar ...
      appBar: MyAppBar(
        showBackArrow: true,
        colorMode: true,
        title: Text(
          'Change Username',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... Headings ...
            Text(
                "Let's Update Your Username!", style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: TextFormField(
                controller: controller.userName,
                validator: (value) => MyAppValidator.validateEmptyText('Username', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: MyAppTexts.userName,
                  prefixIcon: Icon(Iconsax.user_edit),),),),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>controller.updateUserName() ,
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
