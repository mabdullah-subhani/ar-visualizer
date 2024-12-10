import 'dart:io';

import 'package:ar_interior_visualizer/src/repository/authentication/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../exceptions/firebase_auth_exceptions.dart';
import '../../exceptions/format_exception.dart';
import '../../exceptions/platform_exception.dart';
import '../../features/authentication/models/user_model.dart';
import '../../features/visualization/models/item_model.dart';

/// Repository class for user-related operations
class ItemRepository extends GetxController {
  static ItemRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user Item with details to FireStore on the base of current user id.
  Future<void> saveItemRecord(ItemModel item) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final itemData = item.toJson(); // Convert ItemModel to Map
        itemData['id'] = user.uid; // Set current user's ID

        await _db.collection('Items').add(itemData); // Firestore generates unique doc ID
      }
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches items where the current user's ID matches the `id` field.
  Future<List<ItemModel>> fetchUserItems() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final querySnapshot = await _db.collection('Items').where('id', isEqualTo: user.uid).get();

        return querySnapshot.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList();
      } else {
        // Return an empty list if no user is signed in
        return [];
      }
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection('Users').doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update any field in specific user Collection.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to remove user Item from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Items').doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Any Image.
  Future<String> uploadImage (String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
