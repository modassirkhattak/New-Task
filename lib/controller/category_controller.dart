import 'package:get/get.dart';
import 'package:test_task/model/category_model.dart';
import 'package:test_task/utills/api_service.dart';
import 'package:test_task/utills/exception_hundle.dart';

class CategoryController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    // Initialize filteredCategories and set up listener
    everAll([categories, searchQuery], (_) {
      filterCategories();
      print(
        'Search Query: ${searchQuery.value}, Filtered Categories: ${filteredCategories.map((c) => c.name).toList()}',
      );
    });
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final fetchedCategories = await _apiService.fetchCategories();
      categories.assignAll(fetchedCategories);
      filteredCategories.assignAll(
        fetchedCategories,
      ); // Initialize filtered list
    } catch (e) {
      if (e is ApiException) {
        errorMessage.value = e.message;
      } else {
        errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      }
    } finally {
      isLoading.value = false;
    }
  }

  void refreshCategories() {
    fetchCategories();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    print('Updating search query to: $query');
    filterCategories(); // Explicitly call to ensure filtering
  }

  void filterCategories() {
    if (searchQuery.value.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      final query = searchQuery.value.toLowerCase().trim();
      filteredCategories.assignAll(
        categories
            .where((category) => category.name.toLowerCase().contains(query))
            .toList(),
      );
    }
  }

  RxString? get selectedCategory => null;
}
