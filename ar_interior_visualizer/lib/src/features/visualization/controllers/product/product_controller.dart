import 'package:ar_interior_visualizer/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  // RxList<ProductModel> searchProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      /// Show Loader while loading Products
      isLoading.value = true;

      /// Fetch Products from Repository
      final products = await _productRepository.getFeaturedProducts();

      /// Assign Products to the list
      featuredProducts.assignAll(products);
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> allProducts() async {
  //   try {
  //     /// Show Loader while loading Products
  //     isLoading.value = true;
  //
  //     /// Fetch Products from Repository
  //     final products = await _productRepository.getAllProducts();
  //
  //     /// Assign Products to the list
  //     searchProducts.assignAll(products);
  //
  //   } catch (e) {
  //     MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      /// Fetch Products from Repository
      final products = await _productRepository.getAllProducts();
      return products;
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Load selected category data
  Future<List<ProductModel>> getCategoryProducts(String categoryName) async {
    try {
      // Show Loader while loading products
      isLoading.value = true;
      print('Fetching products for category: $categoryName'); // Debugging log

      final categoryProductsList = await _productRepository.getProductsForCategory(categoryName);

      // Update categoryProducts list
      categoryProducts.assignAll(categoryProductsList);
      print('Fetched ${categoryProductsList.length} products for category: $categoryName'); // Debugging log

      return categoryProductsList;
    } catch (e) {
      MyAppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print('Error fetching products for category: $categoryName - $e'); // Debugging log
      return [];
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}

