import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/forgot_password/reset_password/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      ///  Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Processing your request...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();


      // Show Success Message
      MyAppLoaders.successSnackBar(
          title: "Email Sent",
          message:
              "Email Link Sent to Reset your Password.".tr);

      // Redirect
      Get.to(()=> ResetPasswordScreen(email: email.text.trim()));


    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Resend Password Reset Email
  Future<void> resendPasswordResetEmail(String email) async {
    try {
      ///  Start Loading
      MyAppFullScreenLoader.openLoadingDialog(
          'Processing your request...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();


      // Show Success Message
      MyAppLoaders.successSnackBar(
          title: "Email Sent",
          message:
          "Email Link Sent to Reset your Password.".tr);
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}