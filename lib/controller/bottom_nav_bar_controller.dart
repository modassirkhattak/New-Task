// bottom_nav_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/view/category/catagory_screen.dart';
import 'package:test_task/view/favourites/favourites_screen.dart';
import 'package:test_task/view/product_home/product_screen.dart';
import 'package:test_task/view/profile/profile_screen.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  final List<Widget> pages = [
    ProductScreen(),
    CatagoryScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];
}
