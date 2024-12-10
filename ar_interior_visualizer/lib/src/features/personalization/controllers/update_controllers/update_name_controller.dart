import 'package:ar_interior_visualizer/src/features/personalization/controllers/user_controller.dart';
import 'package:ar_interior_visualizer/src/repository/user/user_repository.dart';
import 'package:ar_interior_visualizer/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../routing/routes.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/profile/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
      firstName.text = userController.user.value.firstName;
      lastName.text = userController.user.value.lastName;
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

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {'firstName': firstName.text.trim(), 'lastName': lastName.text.trim()};

      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();


      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Success Screen Message
      MyAppLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated');

      // Mark data as updated
      userController.isDataUpdated.value = true;

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