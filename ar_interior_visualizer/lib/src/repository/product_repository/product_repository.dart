import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common_widgets/services/firebase_storage_service.dart';
import '../../exceptions/firebase_exception.dart';
import '../../exceptions/platform_exception.dart';
import '../../features/visualization/models/product_model.dart';

/// Repository for managing product-related data and operations.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final db = FirebaseFirestore.instance;

  /// Get Limited featured products Limit is 4
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await db.collection('Products').limit(4).get();
      return snapshot.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Feature Something went wrong. Please try again';
    }
  }

  /// Get All products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await db.collection('Products').get();
      final list = snapshot.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'All Something went wrong. Please try again';
    }
  }

  /// Get Selected Category Products
  Future<List<ProductModel>> getProductsForCategory(String categoryName) async {
    try {
      final snapshot = await db.collection('Products')
          .where('CategoryName', isEqualTo: categoryName)  // Match category name in products
          .get();

      // Map the fetched products to your ProductModel
      final result = snapshot.docs.map((doc) {
        return ProductModel.fromSnapshot(doc);  // Convert document data to ProductModel
      }).toList();

      return result;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Get products based on the Query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get products based on the Query
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot )).toList();
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Uploads dummy product data to Firebase Firestore.
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Get a reference to Firebase Storage
      final storage = Get.put(MyAppFirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // Get  thumbnail image data from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image to Firebase Storage and get the download URL
        final thumbnailUrl = await storage.uploadImageData('Products/Thumbnails', thumbnail, product.title);

        // Assign the downloaded URL to the product's thumbnail property
        product.thumbnail = thumbnailUrl;


        // Get 3D image data from local assets
        final product3DImage = await storage.getImageDataFromAssets(product.image);

        // Upload image to Firebase Storage and get the download URL
        // final product3DImageUrl  =
        await storage.uploadImageData('Products/Images', product3DImage, product.title);

        // // Assign the downloaded URL to the product's product3DImage property
        // product.image = product3DImageUrl;

       // Store product in Firestore
        await db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}