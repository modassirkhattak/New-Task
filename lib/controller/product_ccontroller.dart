// product_controller.dart
import 'package:get/get.dart';
import 'package:test_task/model/product_model.dart';
import 'package:test_task/utills/api_service.dart';
import 'package:test_task/utills/exception_hundle.dart';

class ProductController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs; // All products
  final RxList<ProductModel> filteredProducts =
      <ProductModel>[].obs; // Filtered products for display
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalItems = 0.obs;
  final RxBool hasMore = true.obs;
  final RxString searchQuery = ''.obs; // Search query
  final int pageSize = 10;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    everAll([products, searchQuery], (_) {
      filterProducts();
      print(
        'Search Query: ${searchQuery.value}, Filtered Products Count: ${filteredProducts.length}',
      );
    });
  }

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMore.value) return;
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
      products.clear();
      currentPage.value = 1;
      hasMore.value = true;
    }
    errorMessage.value = '';

    try {
      final int skip = (currentPage.value - 1) * pageSize;
      final response = await _apiService.fetchProducts(
        limit: pageSize,
        skip: skip,
      );
      final List<ProductModel> fetchedProducts =
          response['products'] as List<ProductModel>;
      final int total = response['total'] as int;
      totalItems.value = total;

      if (loadMore) {
        products.addAll(fetchedProducts);
      } else {
        products.assignAll(fetchedProducts);
      }

      if (products.length >= totalItems.value) {
        hasMore.value = false;
      } else {
        currentPage.value++;
      }
    } catch (e) {
      if (e is ApiException) {
        errorMessage.value = e.message;
      } else {
        errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      }
    } finally {
      if (loadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  void loadMoreProducts() {
    fetchProducts(loadMore: true);
  }

  void refreshProducts() {
    fetchProducts();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    print('Updating search query to: $query'); // Debug print
  }

  void filterProducts() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredProducts.assignAll(
        products
            .where((product) => product.title.toLowerCase().contains(query))
            .toList(),
      );
    }
    print(
      'Filtered Products: ${filteredProducts.map((p) => p.title).toList()}',
    ); // Debug print
  }
}
