import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s50.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.lightGreyColor),
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          color: isSelected
              ? ColorManager.buttonsBorderColor
              : ColorManager.whiteColor,
        ),
        alignment: currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: AppSize.s14),
        child: Text(
          text,
          style: getRegularTextStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSizeManager.s16,
          ),
        ),
      ),
    );
  }
}