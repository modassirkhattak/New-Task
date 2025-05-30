import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/favorite_ccontroller.dart';
import 'package:test_task/model/product_model.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.productModel});
  final favoriteController = Get.put(FavoriteController());

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MyAppBarWidget(
          title: "Product Details",
          titleImage: true,
          actions: true,

          actionsWidget: null,
          isBottom: false,
          leadingButton: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            productModel.thumbnail,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  children: [
                    CustomTextWidget(
                      text: "Product Details:",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          favoriteController.toggleFavorite(productModel);
                        },
                        child: Icon(
                          favoriteController.isFavorite(productModel)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              favoriteController.isFavorite(productModel)
                                  ? Colors.red
                                  : primaryBlackColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Name:",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.title,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Price:",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.price.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Category:",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.category.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Brand:",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.brand.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Rating :",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.rating.toStringAsFixed(1),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(Icons.star, color: starColor, size: 11),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    CustomTextWidget(
                      text: "Stock :",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                    CustomTextWidget(
                      text: productModel.stock.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: primaryBlackColor,
                      fontFamily: "Poppins",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                CustomTextWidget(
                  text: "Description :",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryBlackColor,
                  fontFamily: "Poppins",
                  textAlign: TextAlign.center,
                ),
                CustomTextWidget(
                  text: productModel.description.toString(),
                  fontSize: 10,
                  maxLines: 10,
                  fontWeight: FontWeight.w400,
                  color: primaryBlackColor,
                  fontFamily: "Poppins",
                  textAlign: TextAlign.start,
                ),
                CustomTextWidget(
                  text: "Product Gallery :",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryBlackColor,
                  fontFamily: "Poppins",
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 300,
                  child: MasonryGridView.count(
                    itemCount: productModel.images.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return Title(
                        title: productModel.images[index],
                        color: primaryBlackColor,
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          child: Image.network(
                            productModel.images[index],
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        // margin: const EdgeInsets.all(4.0),
                        // child: Image.network(
                        //   productModel.images[index],
                        //   fit: BoxFit.cover,
                        //   height: 100,
                        //   width: 100,
                        // ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
