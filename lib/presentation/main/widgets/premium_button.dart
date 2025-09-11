import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumButton extends StatelessWidget {
  final String title;
  final String imageAsset;
  final bool isPremium;
  final VoidCallback onTap;

  const PremiumButton({super.key, required this.title, required this.imageAsset, required this.isPremium, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => isPremium ? onTap() : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isPremium ? ColorManager.sosColor : ColorManager.sosColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(AppSize.s15.r),
            border: Border.all(
              color: isPremium ? ColorManager.borderColor : ColorManager.borderColor.withOpacity(.5),
              width: AppSize.s1.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppSize.s8.w,
              end: AppSize.s8.w,
              top: AppSize.s8.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imageAsset,
                  height: AppSize.s35.h,
                  width: AppSize.s35.w,
                  fit: BoxFit.cover,
                  color: isPremium ? ColorManager.primaryColor : ColorManager.primaryColor.withOpacity(.5),
                ),
                Gap(AppSize.s16.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: getMediumTextStyle(
                    color: isPremium ? ColorManager.blackColor : ColorManager.blackColor.withOpacity(.5),
                    fontSize: FontSizeManager.s16.sp,
                  ),
                ),
              ],
            ),
          ),
        )
        ,
      ),
    );
  }
}
