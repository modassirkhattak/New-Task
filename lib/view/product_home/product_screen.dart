// product_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/product_ccontroller.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/product_details/product_details_screen.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final controller = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !controller.isLoadingMore.value &&
          controller.hasMore.value) {
        controller.loadMoreProducts();
      }
    });

    // Sync searchController with searchQuery for initial value and updates
    ever(controller.searchQuery, (String query) {
      _searchController.text = query;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
      print('Syncing searchController with query: $query'); // Debug print
    });

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MyAppBarWidget(
          title: "Products",
          titleImage: true,
          actions: true,
          actionsWidget: null,
          controller: _searchController,
          onChanged: (value) {
            controller.searchQuery.value = value!;
            controller.filterProducts();
            return;
          },
          leadingButton: false,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomTextWidget(
              text: "${controller.filteredProducts.length} results found",
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
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.value.isNotEmpty) {
                print('Error: ${controller.errorMessage.value}');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.errorMessage.value),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.refreshProducts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (controller.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  controller.refreshProducts();
                },
                child: ListView.builder(
                  itemCount:
                      controller.filteredProducts.length +
                      (controller.hasMore.value ? 1 : 0),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == controller.filteredProducts.length &&
                        controller.hasMore.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final product = controller.filteredProducts[index];
                    return GestureDetector(
                      onTap:
                          () => Get.to(
                            ProductDetailsScreen(productModel: product),
                          ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Center(
                                child: Image.network(
                                  product.images.isNotEmpty
                                      ? product.images[0]
                                      : 'assets/demo_images/product_1.png',
                                  height: 184,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: CustomTextWidget(
                                    text: product.title,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBlackColor,
                                    textAlign: TextAlign.start,
                                    maxLines: 5,
                                    leftPadding: 16,
                                    topPadding: 10,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                // const Spacer(),
                                CustomTextWidget(
                                  text: "\$${product.price}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryBlackColor,
                                  textAlign: TextAlign.center,
                                  maxLines: 5,
                                  rightPadding: 16,
                                  topPadding: 10,
                                  fontFamily: 'Poppins',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomTextWidget(
                                  text: "${product.rating.toStringAsFixed(1)}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryBlackColor,
                                  textAlign: TextAlign.center,
                                  maxLines: 5,
                                  leftPadding: 16,
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
                            CustomTextWidget(
                              text: product.category,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: primaryBlackColor.withOpacity(0.7),
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              leftPadding: 16,
                              topPadding: 10,
                              fontFamily: 'Poppins',
                            ),
                            CustomTextWidget(
                              text: product.description,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              rightPadding: 16,
                              leftPadding: 16,
                              bottomPadding: 17,
                              topPadding: 10,
                              fontFamily: 'Poppins',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
