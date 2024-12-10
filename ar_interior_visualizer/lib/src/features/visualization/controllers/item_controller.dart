
import 'dart:typed_data';

import 'package:ar_interior_visualizer/src/features/visualization/screens/my_products/my_products.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/upload_item/add_new_item.dart';
import 'package:ar_interior_visualizer/src/features/visualization/screens/upload_item/upload_Item.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/item_repository/item_repository.dart';
import '../../../utils/api/api_consumer.dart';
import '../../../utils/constants/images_strings.dart';
import '../../../utils/network_manager/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/item_model.dart';

class ItemController extends GetxController {
  static ItemController get instance => Get.find();

  final isLoading = false.obs;
  RxBool isDataUpdated = false.obs; // New reactive variable to track updates
  Rx<ItemModel> item = ItemModel.empty().obs;
  RxList<ItemModel> allItems = <ItemModel>[].obs;


  // TextField Controllers to get data from TextFields
  final title = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();

  Uint8List? imageFileUint8List;
  final itemRepository = Get.put(ItemRepository());


  GlobalKey<FormState> itemFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    super.onInit();
    fetchUserItems();
  }

  /// Fetch items for the current user
  Future<void> fetchUserItems() async {
    try {
      /// Show Loader while loading Products
      isLoading.value = true;

      /// Fetch Products from Repository
      final item = await itemRepository.fetchUserItems();

      /// Assign Products to the list
      allItems.assignAll(item);

    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
      isDataUpdated.value = false; // Reset after data fetch
    }
  }

  Future<void> upload(Uint8List? imageBytes) async {
    try {
      if (imageBytes == null) throw Exception("No image data provided");

      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog(
          'Uploading your information...', MyAppImages.processingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        throw Exception("No internet connection");
      }

      // Form Validation
      if (!itemFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        throw Exception("Form validation failed");
      }

      // Upload image and get download URL
      final imageUrl = await uploadImageToStorage(imageBytes, DateTime.now().millisecondsSinceEpoch.toString());


      // Save Authenticated user data in Firebase Firestore
      final newItem = ItemModel(
        id: '',
        title: title.text.trim(),
        category: category.text.trim(),
        description: description.text.trim(),
        image: imageUrl,
      );

      final itemRepository = Get.put(ItemRepository());
      await itemRepository.saveItemRecord(newItem);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Clear the text fields after a successful upload
      title.clear();
      category.clear();
      description.clear();

      // Show Success Message
      MyAppLoaders.successSnackBar(
          title: "Congratulations",
          message:
              "Your item has been uploaded!");

      // Mark data as updated
      ItemController.instance.isDataUpdated.value = true;

      // Move to My Product Screen
      Get.until((route) => route.settings.name != '/AddNewItemScreen');


    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload the removed imaged background to the firebase Storage in png format
  Future<String> uploadImageToStorage(Uint8List imageBytes, String fileName) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('items/$fileName.png'); // Save image under "items" folder

    // Upload the image bytes
    await imageRef.putData(imageBytes);

    // Get the download URL
    return await imageRef.getDownloadURL();
  }


  var selectedImage = Rx<XFile?>(null); // To store the selected image
  final ImagePicker picker = ImagePicker();


  /// Function to pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        // Start Loading
        MyAppFullScreenLoader.openLoadingDialog('Image in processing...', MyAppImages.processingAnimation);

        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          MyAppFullScreenLoader.stopLoading();
          return;
        }
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        //remove background from image
        //make image transparent
        imageFileUint8List=await ApiConsumer().removeImageBackgroundApi(imagePath);

        if(imageFileUint8List != null){
          // Show Success Message
          MyAppLoaders.successSnackBar(
            title: "Process Completed",
            message: "Your 2D model has been successfully generated and is ready for use.".tr,
          );
          // Remove Loader
          MyAppFullScreenLoader.stopLoading();

          // Redirect
          Get.off(()=> AddNewItemScreen(imageFileUint8List: imageFileUint8List));
        }
        else{
          // Remove Loader
          MyAppFullScreenLoader.stopLoading();
          MyAppLoaders.errorSnackBar(title: 'Oh Snap!',
              message: "This object is too complex for creating a 2D model; provide a properly framed object".tr
          );

          // Redirect
          Get.off(()=> UploadItemScreen());
        }

      }
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }

  /// Function to capture image from camera
  Future<void> captureImageWithCamera() async {
    try {

      final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        // Start Loading
        MyAppFullScreenLoader.openLoadingDialog(
            'Image in processing...', MyAppImages.processingAnimation);

        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          MyAppFullScreenLoader.stopLoading();
          return;
        }
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        //remove background from image
        //make image transparent
        imageFileUint8List =
        await ApiConsumer().removeImageBackgroundApi(imagePath);

        if (imageFileUint8List != null) {
          // Show Success Message
          MyAppLoaders.successSnackBar(
            title: "Process Completed",
            message: "Your 2D model has been successfully generated and is ready for use.".tr,
          );
          // Remove Loader
          MyAppFullScreenLoader.stopLoading();

          // Redirect
          Get.off(() => AddNewItemScreen(imageFileUint8List: imageFileUint8List));
        }
        else {
          // Remove Loader
          MyAppFullScreenLoader.stopLoading();
          MyAppLoaders.errorSnackBar(title: 'Oh Snap!',
              message: "This object is too complex for creating a 2D model; provide a properly framed object".tr
          );

          // Redirect
          Get.off(()=> UploadItemScreen());
        }
      }
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

