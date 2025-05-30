// font family use google fonts link conditionally in pubspec.yaml file

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textDirection,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.decoration,
    this.decorationStyle,
    this.leftPadding,
    this.rightPadding,
    this.topPadding,
    this.bottomPadding,
    this.horizentalPadding,
    this.verticalPadding,
    this.padding,
    this.fontFamily,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? leftPadding;
  final double? rightPadding;
  final double? topPadding;
  final double? bottomPadding;
  final double? horizentalPadding;
  final double? verticalPadding;
  final EdgeInsets? padding;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ??
          EdgeInsets.only(
            left: leftPadding ?? 0.0,
            right: rightPadding ?? 0.0,
            top: topPadding ?? 0.0,
            bottom: bottomPadding ?? 0.0,
          ),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        overflow: overflow ?? TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        textDirection: textDirection ?? TextDirection.ltr,
        style:
            fontFamily == 'Playfair'
                ? GoogleFonts.playfair(
                  decoration: decoration,
                  decorationStyle: decorationStyle,
                  fontSize: fontSize ?? 16,
                  color: color ?? Colors.black,
                  fontWeight: fontWeight ?? FontWeight.w500,
                )
                : fontFamily == 'Poppins'
                ? GoogleFonts.poppins(
                  decoration: decoration,
                  decorationStyle: decorationStyle,
                  fontSize: fontSize ?? 16,
                  color: color ?? Colors.black,
                  fontWeight: fontWeight ?? FontWeight.w500,
                )
                : GoogleFonts.roboto(
                  decoration: decoration,
                  decorationStyle: decorationStyle,
                  fontSize: fontSize ?? 16,
                  color: color ?? Colors.black,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ), // fontFamily: Roboto
      ),
    );
  }
}
