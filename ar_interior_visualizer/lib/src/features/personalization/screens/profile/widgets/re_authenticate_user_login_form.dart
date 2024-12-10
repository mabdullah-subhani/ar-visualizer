import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common_widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/user_controller.dart';

class ReAuthUserLoginForm extends StatelessWidget {
  const ReAuthUserLoginForm({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const MyAppBar(
        showBackArrow: true,
        title: Text('Re-Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
            child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: MyAppValidator.validateEmail,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: MyAppTexts.email,
                    ),
                  ),

                  const SizedBox(height: MyAppSizes.spaceBtwInputFields),

                  // Password
                  Obx(() => TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.verifyPassword,
                        validator: (value) =>
                            MyAppValidator.validateEmptyText('Password', value),
                        decoration: InputDecoration(
                          labelText: MyAppTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                          ),
                        ),
                      )),

                  const SizedBox(height: MyAppSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),
                        child: const Text('Verify')),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
