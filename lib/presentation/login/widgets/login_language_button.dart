import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginLanguageButton extends StatelessWidget {
  const LoginLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: AppSize.s16.w),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: AppSize.s50.h,
          width: AppSize.s74.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            color: Colors.white,
            border: Border.all(
              color: ColorManager.buttonsBorderColor,
              width: AppSize.s1.w,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: AppSize.s10.w,
                  vertical: AppSize.s13_5.h,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.arabicText.tr(),
                  style: getRegularTextStyle(
                    color: ColorManager.primaryColor,
                    fontSize: AppSize.s16.sp,
                  ),
                ),
              ),
              Icon(
                Icons.language,
                color: ColorManager.primaryColor,
                size: AppSize.s18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
