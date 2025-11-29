import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BackToSignInButton extends StatelessWidget {
  final String route;

  const BackToSignInButton({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;
    return InkWell(
      onTap: () => context.go(route),
      child: Container(
        width: AppSize.s160.w,
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
              Gap(AppSize.s8.w),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 6),
                child: Text(
                  textAlign: TextAlign.center,
                  Strings.backSignIn.tr(),
                  style: getMediumTextStyle(
                    color: ColorManager.primaryColor,
                    fontSize: currentLanguage == 'ar' ? FontSizeManager.s16 : FontSizeManager.s18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
