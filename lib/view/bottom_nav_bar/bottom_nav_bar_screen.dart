// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:test_task/controller/bottom_nav_bar_controller.dart';
import 'package:test_task/utills/app_colors.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({Key? key}) : super(key: key);
  final controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // appBar: AppBar(title: Text('GetX Bottom Navigation')),
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          color: primaryBlackColor,
          padding: const EdgeInsets.only(top: 21, bottom: 2),

          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryBlackColor,
            selectedItemColor: whiteColor,
            unselectedItemColor: whiteColor,
            elevation: 0,
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: whiteColor,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: whiteColor.withOpacity(0.5),
            ),
            items: const [
              BottomNavigationBarItem(
                icon: SvgPicture(
                  SvgAssetLoader('assets/icons/product_bar_icon.svg'),
                  height: 24,
                  width: 24,
                ),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture(
                  SvgAssetLoader('assets/icons/category_bar_icon.svg'),
                  height: 24,
                  width: 24,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture(
                  SvgAssetLoader('assets/icons/fav_bar_icon.svg'),
                  height: 24,
                  width: 24,
                ),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture(
                  SvgAssetLoader('assets/icons/profile_bar_icon.svg'),
                  height: 24,
                  width: 24,
                ),
                label: 'Mitt konto',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
