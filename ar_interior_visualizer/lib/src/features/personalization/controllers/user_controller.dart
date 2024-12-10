import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/authentication/authentication_repository.dart';
import '../../../repository/user/user_repository.dart';
import '../../../utils/constants/images_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/network_manager/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final isDataUpdated = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// Fetch user records
  Future<void> fetchUserRecord() async {
    profileLoading.value = true;
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
      isDataUpdated.value = false;
    }
  }

  /// Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh User Records
      // First update Rx User value & then check if user data is already stored. if not store new data
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final firstName = nameParts[0];
          final lastName =
              nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

          // Generate Username
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '',
              userCredentials.user!.email ?? '');

          // Map data to UserModel
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: firstName,
            lastName: lastName,
            userName: username,
            email: userCredentials.user!.email ?? '',
            phoneNo: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data to Firestore
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      MyAppLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MyAppSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
          child: Text('Cancel'),
        ),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      MyAppFullScreenLoader.openLoadingDialog(
          'Processing', MyAppImages.processingAnimation);

      // Re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re-Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          MyAppFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          MyAppFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthUserLoginForm());
          // await AuthenticationRepository.instance.deleteAccount();
          await reAuthenticateEmailAndPasswordUser();
        }
      }
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- Re-Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      MyAppFullScreenLoader.openLoadingDialog(
          'Processing', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // // Form Validation
      // if (reAuthFormKey.currentState!.validate()) {
      //   MyAppFullScreenLoader.stopLoading();
      //   return;
      // }

      // await AuthenticationRepository.instance
      //     .reAuthenticateWithEmailAndPassword(
      //         verifyEmail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();

      // MyAppFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await userRepository.uploadImage("Users/Images/Profile/", image);

        // Update User Image Record
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        MyAppLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your Profile Image has been updated!",
        );
      }
    } catch (e) {
      MyAppLoaders.errorSnackBar(
        title: "Oops!",
        message: "Something went wrong: $e",
      );
    } finally {
      imageUploading.value = false;
    }
  }

  /// Logout Account Warning
  void logoutAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MyAppSizes.md),
      title: 'Logout Account',
      middleText:
      'Are you sure you want to logout your Account? You saved your credentials, so logging back in will be easy. You can change that from the profile settings screen.',
      confirm: ElevatedButton(
        onPressed: () => AuthenticationRepository.instance.logout(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
          child: Text('Logout'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
          child: Text('Cancel'),
        ),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

}
