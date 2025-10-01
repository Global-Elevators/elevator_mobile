import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.whiteColor,
    primaryColorLight: ColorManager.whiteColor,
    // primaryColorDark: ColorManager.gray600,
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primaryColor,
      disabledColor: ColorManager.primaryColor,
      splashColor: ColorManager.primaryColor,
    ),
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: const EdgeInsets.all(AppPadding.p8), // padding of the input field
      // hintStyle: getRegularTextStyle(color: ColorManager.teal950, fontSize: AppSize.s14),
      // labelStyle: getMediumTextStyle(color: ColorManager.teal950, fontSize: AppSize.s14),
      errorStyle: getRegularTextStyle(color: ColorManager.errorColor),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.greyColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: AppSize.s1_5),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.blackColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
