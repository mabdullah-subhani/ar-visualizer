import 'package:ar_interior_visualizer/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widgets/form/form_header_widget.dart';
import '../../../../../utils/constants/images_strings.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/forgot_password/forgot_password_controller.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: MyAppSizes.md * 7),
                /// Image, Title & Sub-Title
                const FormHeaderWidget(
                  image: MyAppImages.forgotPassImage,
                  title: MyAppTexts.forgotPassTitle,
                  subTitle: MyAppTexts.forgotPassViaMailSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                /// Footer
                Form(
                  key: controller.forgetPasswordFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.email,
                        validator:  MyAppValidator.validateEmail,
                        decoration: const InputDecoration(
                          label: Text(MyAppTexts.email),
                          hintText: MyAppTexts.forgotPassEnterMail,
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.sendPasswordResetEmail(),
                          child: const Text(
                            MyAppTexts.next,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
