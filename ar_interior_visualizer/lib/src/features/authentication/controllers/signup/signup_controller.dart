import 'package:ar_interior_visualizer/src/utils/constants/images_strings.dart';
import 'package:ar_interior_visualizer/src/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/authentication/authentication_repository.dart';
import '../../../../repository/user/user_repository.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final hidePassword = true.obs;
  final userName = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      ///  Start Loading
      MyAppFullScreenLoader.openLoadingDialog(
          'We are processing your information...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;}

      // Form Validation
      if (!signupFormKey.currentState!.validate()){
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;}

      // Attempt to register the user in th Firebase Authentication with the provided email and password
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
      final uid = userCredential.user!.uid;

      // Save Authenticated user data in Firebase Firestore
      final newUser = UserModel(
        id: uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNo: phoneNo.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();


      // // Show Success Message
      // MyAppLoaders.successSnackBar(
      //     title: "Congratulations",
      //     message:
      //         "Your account has been created! Verify your email to continue.");
      //
      // // Move to Verify Email screen
      // Get.to(() =>  VerifyEmailScreen(email: email.text.trim()));

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
