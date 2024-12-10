import 'package:ar_interior_visualizer/navigation_menu.dart';
import 'package:ar_interior_visualizer/src/repository/user/user_repository.dart';
import 'package:ar_interior_visualizer/src/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/images_strings.dart';
import '../../../utils/network_manager/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../screens/my_products/my_products.dart';
import 'item_controller.dart';


class UpdateItemDetailsController extends GetxController {
  // Constructor to receive itemId
  UpdateItemDetailsController({required this.docId});

  static UpdateItemDetailsController get instance => Get.find();


  final String docId; // Firestore document ID
  final title = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final GlobalKey<FormState> updateItemDetailsFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchItemDetails(); // Fetch and populate item details when the controller initializes
  }

  Future<void> fetchItemDetails() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('Items').doc(docId).get();
      if (docSnapshot.exists) {
        final itemData = docSnapshot.data()!;
        title.text = itemData['Title'];
        category.text = itemData['Category'];
        description.text = itemData['Description'];
      } else {
        throw 'Item not found';
      }
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> updateItemDetails() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Updating item details...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateItemDetailsFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Update item in Firestore
      await FirebaseFirestore.instance.collection('Items').doc(docId).update({
        'Title': title.text.trim(),
        'Category': category.text.trim(),
        'Description': description.text.trim(),
      });

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Clear the text fields after a successful upload
      title.clear();
      category.clear();
      description.clear();

      // Success Screen Message
      MyAppLoaders.successSnackBar(title: 'Congratulations', message: 'Your Item Details has been updated');

      // Mark data as updated
      ItemController.instance.isDataUpdated.value = true;

      // Move to My Product Screen
      Get.until((route) => route.settings.name != '/ChangeItemDetailsScreen');

    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Deletes the item from Firestore using the document ID
  Future<void> deleteItem() async {
    try {
      // Confirm with the user before deletion (optional, but recommended)
      final confirmed = await Get.dialog(
        AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false), // Cancel
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true), // Confirm
              child: Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed != true) return; // Exit if user cancels the deletion

      // Delete the item from Firestore
      await FirebaseFirestore.instance.collection('Items').doc(docId).delete();

      // Success Screen Message
      MyAppLoaders.successSnackBar(title: 'Success', message: 'The item has been deleted successfully.');

      // Mark data as updated
      ItemController.instance.isDataUpdated.value = true;

    } catch (e) {
      // Notify the user of any error
      Get.snackbar('Error', 'Failed to delete item: ${e.toString()}');
    }
  }

}
