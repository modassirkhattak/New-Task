import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/widget/custom_appbar.dart';
import 'package:test_task/widget/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MyAppBarWidget(
          title: "Mitt konto",
          titleImage: true,
          actions: true,
          isBottom: false,
          actionsWidget: null,
          leadingButton: false,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 21),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primaryBlackColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: greyColor,
                  backgroundImage: AssetImage(
                    "assets/demo_images/product_1.png",
                  ),
                ),
                Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: "Mudassir Khan",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                      // textAlign: TextAlign.center,
                      maxLines: 5,
                      // rightPadding: 16,
                      // topPadding: 10,
                      fontFamily: 'Poppins',
                    ),
                    CustomTextWidget(
                      text: "modassirhabib9@gmail.com",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,

                      maxLines: 5,

                      fontFamily: 'Poppins',
                    ),
                    CustomTextWidget(
                      text: "+923325267139",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,

                      maxLines: 5,

                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          listTilesWidget(
            title: "Kontoinstallningar",
            imagePath: "assets/icons/setting_icon.svg",
          ),
          listTilesWidget(
            title: "Mina betalmetoder",
            imagePath: "assets/icons/mina_beta_icon.svg",
          ),
          listTilesWidget(
            title: "Support",
            imagePath: "assets/icons/support_icon.svg",
          ),
        ],
      ),
    );
  }
}

Widget listTilesWidget({required String imagePath, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 13),
    child: Row(
      spacing: 19,
      children: [
        SvgPicture.asset(imagePath, height: 24, width: 24),
        CustomTextWidget(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: primaryBlackColor,
          maxLines: 5,
          fontFamily: 'Poppins',
        ),
      ],
    ),
  );
}
