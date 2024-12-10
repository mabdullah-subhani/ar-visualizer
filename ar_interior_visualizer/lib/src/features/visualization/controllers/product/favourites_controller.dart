import 'dart:convert';

import 'package:get/get.dart';

import '../../../../repository/product_repository/product_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs;
  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  /// Method to Initialize favourites by reading from storage
  void initFavourites() {
    final json = MyAppLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavoritesToStorage();
      MyAppLoaders.customToast(message: 'Product has been added to the Favourites.');
    } else {
      MyAppLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavoritesToStorage();
      favourites.refresh();
      MyAppLoaders.customToast(message: 'Product has been removed from the Favourites.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favourites);
    MyAppLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }
}
