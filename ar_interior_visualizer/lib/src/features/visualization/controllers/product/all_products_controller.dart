import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../repository/product_repository/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) {
        return [];
      }
      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;

      case 'Newest':
        products.sort((a, b) => b.date!.compareTo(a.date!)); // Assuming newest means descending date
        break;

      case 'Sofa':
      case 'Bed':
      case 'Chair':
      case 'Table':
      case 'Lamp':
      // Move items with the selected category to the start
        products.sort((a, b) {
          if (a.categoryName == sortOption && b.categoryName != sortOption) {
            return -1; // 'a' comes before 'b'
          } else if (a.categoryName != sortOption && b.categoryName == sortOption) {
            return 1; // 'b' comes before 'a'
          } else {
            return 0; // Equal, keep the order
          }
        });
        break;

      default:
      // Default sorting: Name
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    // Assign products to the 'products' list
    this.products.assignAll(products);

    // Sort the products based on the current sorting option
    sortProducts('Name');
  }
}