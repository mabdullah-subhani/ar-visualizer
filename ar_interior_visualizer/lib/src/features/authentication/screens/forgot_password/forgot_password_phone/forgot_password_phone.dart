import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widgets/form/form_header_widget.dart';
import '../../../../../utils/constants/images_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../forgot_password_otp/otp_screen.dart';

class ForgotPasswordPhoneScreen extends StatelessWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  subTitle: MyAppTexts.forgotPassViaPhoneNoSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(MyAppTexts.phoneNo),
                          hintText: MyAppTexts.forgotPassEnterPhoneNo,
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const OtpScreen()),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
