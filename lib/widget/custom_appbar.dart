import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/widget/custom_text.dart';
import 'package:test_task/widget/custom_textfield.dart';

class MyAppBarWidget extends StatelessWidget {
  const MyAppBarWidget({
    super.key,
    this.title,
    this.actions,
    this.actionsWidget,
    this.titleImage,
    this.isBottom,
    this.leadingButton,
    this.controller,
    this.onChanged,
  });

  final String? title;
  final bool? actions;
  final bool? leadingButton;
  final bool? titleImage;
  final bool? isBottom;
  final Widget? actionsWidget;
  final TextEditingController? controller;
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: whiteColor,
      scrolledUnderElevation: 0,
      // actionsPadding: EdgeInsets.only(right: 16),
      elevation: 0,
      leading:
          leadingButton == true
              ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: primaryBlackColor),
              )
              : null,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:
          titleImage == true
              ? CustomTextWidget(
                text: title.toString(),
                fontSize: 24,
                fontFamily: 'Playfair',
                color: primaryBlackColor,
                fontWeight: FontWeight.w600,
              )
              : Image(
                image: AssetImage('assets/extra_images/app_logo.png'),
                height: 40,
              ),
      bottom:
          isBottom == false
              ? null
              : PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 21.0,
                    right: 21,
                    top: 10,
                  ),
                  child: CustomTextField(
                    hintText: "iphone",
                    textEditingController: controller,
                    onChanged: onChanged,
                    borderRadius: 5,
                    height: 40,

                    elevation: 0,
                    shadowColor: Colors.transparent,

                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                ),
              ),
      /* actions:
          actions == true
              ? [actionsWidget ?? Container()]
              : [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons_svg/cart_icon.svg',
                    color: whiteColor,
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons_svg/notification.svg',
                    color: whiteColor,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],*/
    );
  }
}
