import 'package:ar_interior_visualizer/src/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ar_interior_visualizer/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: MyAppSizes.defaultSpace),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /// First Name
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) => MyAppValidator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: MyAppTexts.signUpFirstName,
                      hintText: MyAppTexts.signUpEnterName,
                    ),
                  ),
                ),
                const SizedBox(width: MyAppSizes.spaceBtwInputFields),

                /// Last Name
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        MyAppValidator.validateEmptyText('Second Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: MyAppTexts.signUpLastName,
                      hintText: MyAppTexts.signUpEnterName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            /// Username
            TextFormField(
              controller: controller.userName,
              validator: (value) =>
                  MyAppValidator.validateEmptyText('User Name', value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_edit),
                labelText: MyAppTexts.signUpUserName,
                hintText: MyAppTexts.signUpEnterUserName,
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => MyAppValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: MyAppTexts.email,
                hintText: MyAppTexts.signUpEnterEmail,
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            /// Phone No
            TextFormField(
              controller: controller.phoneNo,
              validator: (value) => MyAppValidator.validateEmptyText('Phone No', value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_outlined),
                labelText: MyAppTexts.phoneNo,
                hintText: MyAppTexts.signUpEnterPhoneNo,
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            /// Password
            Obx(
              () =>  TextFormField(
                controller: controller.password,
                validator: (value) => MyAppValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  labelText: MyAppTexts.password,
                  hintText: MyAppTexts.signUpEnterPass,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon:  Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwItems),

            /// Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                    // Get.to(() => const VerifyEmailScreen()),
                child: Text(
                  MyAppTexts.signup.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
