import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/category_filter_by_controller.dart';
import 'package:test_task/controller/product_ccontroller.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/product_details/product_details_screen.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class ProductByCategoryScreen extends StatelessWidget {
  ProductByCategoryScreen({super.key, required this.categoryName});

  final categoryController = Get.put(CategoryFilterByController());
  final productController = Get.find<ProductController>();

  final searchController = TextEditingController();
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    // Fetch products by category when the screen is initialized

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MyAppBarWidget(
          title: categoryName,
          titleImage: true,
          actions: true,
          controller: searchController,
          onChanged: (value) {
            categoryController.updateSearchQuery(value!);
            categoryController.filteredProducts();
            return;
          },
          actionsWidget:
              null, // SvgPicture.asset('assets/icons_svg/share_icon.svg'),
          leadingButton: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomTextWidget(
              text:
                  "${categoryController.filteredProducts.length} results found",
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: primaryBlackColor,
              textAlign: TextAlign.center,
              maxLines: 5,
              leftPadding: 32,

              // bottomPadding: 133,
              // rightPadding: 38,
              topPadding: 10,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(categoryController.errorMessage.value),
                );
              } else if (categoryController.filteredProducts.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }

              return ListView.builder(
                itemCount: categoryController.filteredProducts.length,
                // c
                itemBuilder: (context, index) {
                  final category = categoryController.filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      // productController.selectedProduct.value = category;
                      Get.to(
                        () => ProductDetailsScreen(productModel: category),
                      );
                    },
                    child: Container(
                      // padding: const EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: primaryBlackColor.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(category.thumbnail),
                            ),
                          ),
                          Row(
                            children: [
                              CustomTextWidget(
                                text: category.title,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryBlackColor,
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                leftPadding: 16,
                                // bottomPadding: 133,
                                // rightPadding: 38,
                                topPadding: 10,
                                fontFamily: 'Poppins',
                              ),
                              Spacer(),
                              CustomTextWidget(
                                text: "\$${category.price}",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryBlackColor,
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                // leftPadding: 38,
                                // bottomPadding: 133,
                                rightPadding: 16,
                                topPadding: 10,
                                fontFamily: 'Poppins',
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              CustomTextWidget(
                                text: category.rating.toStringAsFixed(1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryBlackColor,
                                textAlign: TextAlign.center,
                                maxLines: 5,

                                leftPadding: 16,
                                // bottomPadding: 133,
                                // rightPadding: 38,
                                // topPadding: 10,
                                fontFamily: 'Poppins',
                              ),
                              // Spacer(),
                              Row(
                                children: List.generate(
                                  5,
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
                            text: category.brand,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: primaryBlackColor.withOpacity(0.7),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            leftPadding: 16,
                            // bottomPadding: 133,
                            // rightPadding: 38,
                            topPadding: 10,
                            fontFamily: 'Poppins',
                          ),
                          CustomTextWidget(
                            text: category.description,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            // color: primaryBlackColor.withOpacity(0.0),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            rightPadding: 16,
                            leftPadding: 16,
                            bottomPadding: 17,
                            // rightPadding: 38,
                            topPadding: 10,
                            fontFamily: 'Poppins',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),

            // GridView.builder(
          ),
        ],
      ),
    );
  }
}
