import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FreeButton extends StatelessWidget {
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  const FreeButton({super.key, required this.imageAsset, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s130.h,
        width: AppSize.s181.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s22.r),
          border: Border.all(
            color: ColorManager.borderColor,
            width: AppSize.s1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: AppSize.s16.w,
            end: AppSize.s16.w,
            top: AppSize.s16.h,
          ),
          child: Column(
            children: [
              Image.asset(imageAsset, fit: BoxFit.cover),
              Gap(AppSize.s16.h),
              Text(
                title,
                style: getMediumTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
