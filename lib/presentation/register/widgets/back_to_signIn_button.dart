import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BackToSignInButton extends StatelessWidget {
  const BackToSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s40,
      width: AppSize.s150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s99.r),
        color: ColorManager.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios_new, size: AppSize.s20),
          Gap(AppSize.s5.w),
          Text(
            Strings.backSignIn,
            style: getMediumTextStyle(
              color: ColorManager.blueColor,
              fontSize: FontSizeManager.s18,
            ),
          ),
        ],
      ),
    );
  }
}