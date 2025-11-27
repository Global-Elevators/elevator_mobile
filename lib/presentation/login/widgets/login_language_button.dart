import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/functions.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginLanguageButton extends StatelessWidget {
  const LoginLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;
    return Padding(
      padding: EdgeInsetsDirectional.only(end: AppSize.s16.w),
      child: InkWell(
        onTap: () => changeLanguage(context),
        child: Container(
          height: AppSize.s50.h,
          width: AppSize.s80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            color: Colors.white,
            border: Border.all(
              color: ColorManager.buttonsBorderColor,
              width: AppSize.s1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSize.s5.w,
            children: [
              Text(
                textAlign: TextAlign.center,
                currentLanguage == 'en'
                    ? "عربي"
                    : "english",
                style: getRegularTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: AppSize.s16.sp,
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
