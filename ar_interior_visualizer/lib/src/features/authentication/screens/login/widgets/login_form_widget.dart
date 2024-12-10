import 'package:ar_interior_visualizer/src/features/authentication/controllers/login/login_controller.dart';
import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../forgot_password/forgot_password_mail/forgot_password_mail.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: MyAppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => MyAppValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: MyAppTexts.login,
                hintText: MyAppTexts.loginEnterEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            /// Password
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                validator: (value) => MyAppValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  labelText: MyAppTexts.password,
                  hintText: MyAppTexts.loginEnterPass,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Obx(
                  () => Row(
                    children: [
                      Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value),
                      Text.rich(
                        TextSpan(
                          text: MyAppTexts.loginRememberMe,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Forgot Password
                TextButton(
                  onPressed: ()=> Get.to(()=> ForgotPasswordMailScreen()),
                  child: Text.rich(
                    TextSpan(
                      text: MyAppTexts.loginForgotPass,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            /// Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.login(),
                child: Text(
                  MyAppTexts.login.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
