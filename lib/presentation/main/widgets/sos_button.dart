import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SosButton extends StatelessWidget {
  final bool isPremium;

  const SosButton(this.isPremium, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isPremium ? () {} : null,
      child: Container(
        height: AppSize.s50.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPremium
              ? ColorManager.errorColor
              : ColorManager.errorColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppSize.s18.r),
        ),
        child: Text(
          Strings.sosTitle,
          style: TextStyle(
            fontFamily: "PlayfairDisplay",
            fontWeight: FontWeight.bold,
            fontSize: FontSizeManager.s18.sp,
            color: ColorManager.whiteColor,
          ),
        ),
      ),
    );
  }
}
