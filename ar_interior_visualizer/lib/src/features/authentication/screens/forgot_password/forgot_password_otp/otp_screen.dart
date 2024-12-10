import 'package:ar_interior_visualizer/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/images_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Image
                Image(
                  image: const AssetImage(MyAppImages.forgotPassOTPImage),
                  width: MyAppHelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),

                /// Title & SubTitle
                Text(
                    MyAppTexts.otpTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),
                Text(
                  MyAppTexts.otpTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: MyAppSizes.spaceBtwItems),
                Text(
                  MyAppTexts.otpSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: MyAppSizes.spaceBtwSections),

                OtpTextField(
                  numberOfFields: 6,
                  fieldWidth: 38,
                  fillColor: MyAppColors.darkSecondaryColor.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    print("OTP is => $code");
                  },
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        MyAppTexts.confirm,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
