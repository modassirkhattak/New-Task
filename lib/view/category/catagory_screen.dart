// catagory_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/category_controller.dart';
import 'package:test_task/controller/category_filter_by_controller.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/product_by_category/product_by_category_screen.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class CatagoryScreen extends StatelessWidget {
  CatagoryScreen({super.key});
  final controller = Get.put(CategoryController());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Add listener for infinite scrolling
    // Sync searchController with searchQuery
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
          title: "Categories",
          titleImage: true,
          actions: true,
          actionsWidget: null,
          leadingButton: false,
          controller: _searchController,
          onChanged: (value) {
            controller.updateSearchQuery(value!);
            controller.filterCategories();
            return;
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomTextWidget(
              text: "${controller.categories.length} results found",
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
                return Center(child: Text(controller.errorMessage.value));
              } else if (controller.categories.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  controller.refreshCategories();
                },
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: controller.filteredCategories.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.99,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  semanticChildCount: 2,
                  itemBuilder: (context, index) {
                    if (index == controller.filteredCategories.length) {
                      // Show loading indicator at the bottom while fetching more
                      return const Center(child: CircularProgressIndicator());
                    }

                    final product = controller.filteredCategories[index];
                    return GestureDetector(
                      onTap: () {
                        Get.put(
                          CategoryFilterByController(),
                        ).setCategoryUrl(product.url);
                        Get.to(
                          ProductByCategoryScreen(categoryName: product.name),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlackColor.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(product.url),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: CustomTextWidget(
                          text: product.name,
                          fontSize: 12,
                          leftPadding: 22,
                          bottomPadding: 21,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.w600,
                          color: primaryBlackColor,
                          fontFamily: "Poppins",
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
