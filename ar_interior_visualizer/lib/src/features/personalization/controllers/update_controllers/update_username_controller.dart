import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:ar_interior_visualizer/src/features/personalization/screens/profile/profile.dart';
import 'package:ar_interior_visualizer/src/repository/user/user_repository.dart';
import 'package:ar_interior_visualizer/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';


class UpdateUserNameController extends GetxController {
  static UpdateUserNameController get instance => Get.find();

  final userName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeUserNames();
    super.onInit();
  }

  Future<void> initializeUserNames() async {
    userName.text = userController.user.value.userName;
  }

  Future<void> updateUserName() async {
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
      Map<String, dynamic> name = {'userName': userName.text.trim()};

      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.userName = userName.text.trim();

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Success Screen Message
      MyAppLoaders.successSnackBar(title: 'Congratulations', message: 'Your Username has been updated');

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