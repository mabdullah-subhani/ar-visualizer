import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';
import 'package:ar_interior_visualizer/src/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../repository/authentication/authentication_repository.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// -- Email & Password Login
  Future<void> login() async {
    try {
      ///  Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Processing your information...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login User using Email and Password
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      ///  Start Loading
      MyAppFullScreenLoader.openLoadingDialog(
          'Logging you in...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Login User using Email and Password
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Records
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
