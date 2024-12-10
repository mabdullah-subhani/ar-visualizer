import 'package:ar_interior_visualizer/src/features/authentication/screens/forgot_password/forgot_password_phone/forgot_password_phone.dart';
import 'package:ar_interior_visualizer/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../forgot_password_mail/forgot_password_mail.dart';
import 'forgot_password_btn_widget.dart';

class ForgotPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(MyAppSizes.defaultSpace - 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Bottom Sheet Title
            Text(MyAppTexts.forgotPassOptionTitle,
                style: Theme.of(context).textTheme.headlineLarge),
            /// Bottom Sheet Sub-Title
            Text(MyAppTexts.forgotPassOptionSubTitle,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 50.0),

            /// Forgot Password Via Mail
            ForgotPassBtnWidget(
                btnIcon: Icons.mail_outline_rounded,
                title: MyAppTexts.email,
                subtitle: MyAppTexts.forgotViaMail,
                onTap: () {
                  Get.to(() => const ForgotPasswordMailScreen());
                }),
            const SizedBox(height: 25.0),

            /// Forgot Password Via PhoneNo
            ForgotPassBtnWidget(
                btnIcon: Icons.mobile_friendly_rounded,
                title: MyAppTexts.phoneNo,
                subtitle: MyAppTexts.forgotViaPhone,
                onTap: () {
                  Get.to(() => const ForgotPasswordPhoneScreen());
                })
          ],
        ),
      ),
    );
  }
}
