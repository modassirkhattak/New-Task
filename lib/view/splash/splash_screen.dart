import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:test_task/widget/custom_text.dart';
// import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  /*************  ✨ Windsurf Command ⭐ 
   * 
   * 
   * 
   * 
   * 
   *  *************/
  /*******  28d32c6f-d5d7-49e0-b658-52bdfe5ed547  *******/
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => BottomNavBarScreen());
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryBlackColor.withOpacity(0.6),
                    primaryBlackColor,
                    primaryBlackColor,
                    primaryBlackColor,
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/demo_images/splash_screen.png',
                  ), // Add this image in assets
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  opacity: 0.6,
                ),
              ),
              child: Column(
                children: [
                  // SizedBox(height: 72),
                  CustomTextWidget(
                    text: "My Store",
                    fontSize: 50,
                    topPadding: 72,
                    fontWeight: FontWeight.w400,
                    color: primaryBlackColor,
                    fontFamily: 'Playfair',
                  ),
                  Spacer(),
                  CustomTextWidget(
                    text: "Valkommen",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    fontFamily: 'Poppins',
                  ),
                  CustomTextWidget(
                    text:
                        "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: whiteColor,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    leftPadding: 38,
                    bottomPadding: 133,
                    rightPadding: 38,
                    topPadding: 10,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
