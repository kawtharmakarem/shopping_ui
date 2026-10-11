import 'package:flutter/material.dart';
import 'package:shopping/core/resources/color_manager.dart';

class AppStyles {
  AppStyles._();
  static TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      fontFamily: "Sentic Display",
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColors.black,
    );
  }

  static TextStyle getRegularStyle(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w400);
  }

  static TextStyle getLightStyle(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w300);
  }

  static TextStyle getMediumStyle(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w500);
  }

  static TextStyle getSemiBoldStyle(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w600);
  }

  static TextStyle getBoldStyle(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w700);
  }
}
