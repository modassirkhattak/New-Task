import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/favorite_ccontroller.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/product_details/product_details_screen.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});
  final favoriteController = Get.put(FavoriteController());

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MyAppBarWidget(
          title: "Favourites",
          titleImage: true,
          actions: false,
          actionsWidget: null,
          isBottom: true,
          controller: searchController,
          onChanged: (value) {
            // No search functionality in favorites
            favoriteController.updateSearchQuery(value!);
          },

          leadingButton: false,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomTextWidget(
              text:
                  "${favoriteController.favoriteProducts.length} favorites found",
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: primaryBlackColor,
              textAlign: TextAlign.center,
              maxLines: 5,
              leftPadding: 32,
              topPadding: 10,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Obx(() {
              if (favoriteController.filteredFavoriteProducts.isEmpty) {
                return const Center(child: Text('No favorite products added.'));
              }

              return ListView.builder(
                itemCount: favoriteController.filteredFavoriteProducts.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  final product = favoriteController.favoriteProducts[index];
                  return GestureDetector(
                    onTap:
                        () =>
                            Get.to(ProductDetailsScreen(productModel: product)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 21,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: primaryBlackColor.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              product.thumbnail,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  width: 120,
                                  color: greyColor,
                                  child: const Icon(Icons.broken_image),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    text: product.title,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlackColor,
                                    maxLines: 2,
                                    fontFamily: 'Poppins',
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextWidget(
                                    text: "\$${product.price}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlackColor,
                                    maxLines: 1,
                                    fontFamily: 'Poppins',
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      CustomTextWidget(
                                        text:
                                            "${product.rating.toStringAsFixed(1)}",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: primaryBlackColor,
                                        maxLines: 1,
                                        fontFamily: 'Poppins',
                                      ),
                                      const SizedBox(width: 8),
                                      Row(
                                        children: List.generate(
                                          product.rating.toInt(),
                                          (index) => Icon(
                                            Icons.star,
                                            color: starColor,
                                            size: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CustomTextWidget(
                                    text: product.category,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: primaryBlackColor.withOpacity(0.7),
                                    maxLines: 1,
                                    fontFamily: 'Poppins',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: IconButton(
                              onPressed: () {
                                favoriteController.toggleFavorite(product);
                              },
                              icon: Icon(
                                favoriteController.isFavorite(product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    favoriteController.isFavorite(product)
                                        ? Colors.red
                                        : greyColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
