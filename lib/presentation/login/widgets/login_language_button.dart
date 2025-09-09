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
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: AppSize.s80.w,
            height: AppSize.s40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s8.r),
              color: ColorManager.whiteColor,
            ),
            alignment: Alignment.center,
            child: Text(
              Strings.arabicText,
              style: getRegularTextStyle(
                color: ColorManager.primaryColor,
                fontSize: AppSize.s18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
