import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.welcomeBack,
              style: getMediumTextStyle(
                color: ColorManager.orangeColor,
                fontSize: FontSizeManager.s18.sp,
              ),
            ),
            Text(
              Strings.userName,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
            ),
          ],
        ),
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: AppSize.s45.h,
              width: AppSize.s45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14.r),
                border: Border.all(
                  color: ColorManager.buttonsBorderColor,
                  width: AppSize.s1.w,
                ),
              ),
            ),
            SvgPicture.asset(
              ImageAssets.notification,
              width: AppSize.s20.w,
              height: AppSize.s20.h,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                ColorManager.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
