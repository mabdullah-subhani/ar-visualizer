import 'package:ar_interior_visualizer/src/features/visualization/controllers/product/product_controller.dart';
import 'package:get/get.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

class SearchScreenController extends GetxController {
  static SearchScreenController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductModel> searchResults = <ProductModel>[].obs;

  /// Reference to the ProductController
  final productController = ProductController.instance;

  /// Filter products based on the search keyword
  void searchProducts(String searchKeyword) async {
    try {
      /// Show Loader while loading Products
      isLoading.value = true;

      /// Convert the keyword to lowercase for case-insensitive matching
      final keyword = searchKeyword.trim().toLowerCase();

      /// Ensure products are loaded before filtering
      final allProducts = await productController.fetchAllProducts();

      /// Filter the products based on the keyword
      searchResults.value = allProducts.where((product) {
        final title = product.title.toLowerCase();
        final category = product.categoryName.toLowerCase();
        return title.contains(keyword) || category.contains(keyword);
      }).toList();
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
