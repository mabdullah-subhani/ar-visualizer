import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/profile.dart';
import 'package:ar_interior_visualizer/src/repository/user/user_repository.dart';
import 'package:ar_interior_visualizer/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';


class UpdatePhoneNoController extends GetxController {
  static UpdatePhoneNoController get instance => Get.find();

  final phoneNo = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePhoneNo();
    super.onInit();
  }

  Future<void> initializePhoneNo() async {
    phoneNo.text = userController.user.value.phoneNo;
  }

  Future<void> updatePhoneNo() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Updating your information...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Update username in the Firebase Firestore
      Map<String, dynamic> phone = {'phoneNo': phoneNo.text.trim()};

      await userRepository.updateSingleField(phone);

      // Update the Rx User value
      userController.user.value.phoneNo = phoneNo.text.trim();

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Success Screen Message
      MyAppLoaders.successSnackBar(title: 'Congratulations', message: 'Your Phone Number has been updated');

      // Move to previous Screen
      Get.off(()=>const ProfileScreen());
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


}