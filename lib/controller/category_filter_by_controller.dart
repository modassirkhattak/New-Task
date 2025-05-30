// product_controller.dart
import 'package:get/get.dart';
import 'package:test_task/model/product_model.dart';
import 'package:test_task/utills/api_service.dart';
import 'package:test_task/utills/exception_hundle.dart';

class CategoryFilterByController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalItems = 0.obs;
  final RxBool hasMore = true.obs;
  final RxString searchQuery = ''.obs;
  final int pageSize = 10;
  RxString? selectedCategoryUrl; // Store the category URL instead of slug

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    everAll([products, searchQuery], (_) => _filterProducts());
  }

  Future<void> fetchProducts({
    bool loadMore = false,
    String? categoryUrl,
  }) async {
    if (loadMore) {
      if (!hasMore.value) return;
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
      products.clear();
      currentPage.value = 1;
      hasMore.value = true;
      selectedCategoryUrl = categoryUrl != null ? RxString(categoryUrl) : null;
    }
    errorMessage.value = '';

    try {
      final int skip = (currentPage.value - 1) * pageSize;
      Map<String, dynamic> response;
      if (selectedCategoryUrl != null) {
        response = await _apiService.fetchProductsByUrl(
          categoryUrl: selectedCategoryUrl!.value,
          limit: pageSize,
          skip: skip,
        );
      } else {
        response = await _apiService.fetchProducts(limit: pageSize, skip: skip);
      }
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
  }

  void _filterProducts() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredProducts.assignAll(
        products
            .where(
              (product) =>
                  product.title.toLowerCase().contains(query) ||
                  product.category.toLowerCase().contains(query),
            )
            .toList(),
      );
    }
  }

  void setCategoryUrl(String? categoryUrl) {
    selectedCategoryUrl = categoryUrl != null ? RxString(categoryUrl) : null;
    fetchProducts(categoryUrl: categoryUrl);
  }
}
