import 'package:get/get.dart';
import 'package:test_task/model/product_model.dart';

class FavoriteController extends GetxController {
  final RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;
  final RxList<ProductModel> filteredFavoriteProducts = <ProductModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    filteredFavoriteProducts.assignAll(favoriteProducts);
    everAll([favoriteProducts, searchQuery], (_) {
      _filterFavorites();
      print(
        'Search Query: ${searchQuery.value}, Filtered Favorites: ${filteredFavoriteProducts.map((p) => p.title).toList()}',
      );
    });
  }

  bool isFavorite(ProductModel product) {
    return favoriteProducts.any((p) => p.id == product.id);
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      favoriteProducts.removeWhere((p) => p.id == product.id);
      print('Removed ${product.title} from favorites');
    } else {
      favoriteProducts.add(product);
      print('Added ${product.title} to favorites');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    print('Updating search query to: $query');
  }

  void _filterFavorites() {
    if (searchQuery.value.isEmpty) {
      filteredFavoriteProducts.assignAll(favoriteProducts);
    } else {
      final query = searchQuery.value.toLowerCase().trim();
      filteredFavoriteProducts.assignAll(
        favoriteProducts
            .where((product) => product.title.toLowerCase().contains(query))
            .toList(),
      );
    }
  }
}
