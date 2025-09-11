import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BackToButton extends StatelessWidget {
  final String text;

  const BackToButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pop(),
      child: Container(
        width: AppSize.s150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s99.r),
          color: Color(0xffFAFAFA),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppSize.s12.w,
            vertical: AppSize.s14.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new, size: AppSize.s16),
              Gap(AppSize.s10.w),
              Text(
                textAlign: TextAlign.center,
                Strings.backSignIn,
                style: getMediumTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
