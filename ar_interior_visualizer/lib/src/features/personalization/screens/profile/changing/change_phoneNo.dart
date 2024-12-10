import 'package:ar_interior_visualizer/src/common_widgets/appbar/appbar.dart';
import 'package:ar_interior_visualizer/src/features/personalization/controllers/update_controllers/updatea_phoneNo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class ChangePhoneNoScreen extends StatelessWidget {
  const ChangePhoneNoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNoController());
    return Scaffold(
      // ... AppBar ...
      appBar: MyAppBar(
        showBackArrow: true,
        colorMode: true,
        title: Text(
          'Change Phone Number',
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
                "Let's Update Your Phone Number!", style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: TextFormField(
                controller: controller.phoneNo,
                validator: (value) => MyAppValidator.validateEmptyText('Phone No', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: MyAppTexts.phoneNo,
                  prefixIcon: Icon(Icons.phone_outlined),),),),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>controller.updatePhoneNo() ,
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
