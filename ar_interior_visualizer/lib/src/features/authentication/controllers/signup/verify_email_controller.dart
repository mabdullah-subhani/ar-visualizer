import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/success_screen_widget/success_screen.dart';
import '../../../../repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Email Verification link
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MyAppLoaders.successSnackBar(
          title: "Email Sent", message: "Please check your inbox and verify your email.");
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

// Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
              () => SuccessScreen(
            image: MyAppImages.successImage,
            title: MyAppTexts.successScreenTitle,
            subTitle: MyAppTexts.successScreenSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

// Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
            () => SuccessScreen(
          image: MyAppImages.successImage,
          title: MyAppTexts.successScreenTitle,
          subTitle: MyAppTexts.successScreenSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}