import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CustomBottomSheet {
  static Future<dynamic> show({
    required BuildContext context,
    required String message,
    required String buttonText,
    String? imagePath,
    VoidCallback? onButtonPressed,
    Color backgroundColor = Colors.white,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => Container(
        width: double.infinity.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s50.r),
            topRight: Radius.circular(AppSize.s50.r),
          ),
        ),
        padding: EdgeInsetsDirectional.only(
          top: AppSize.s30.h,
          end: AppSize.s16.w,
          start: AppSize.s16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null) SvgPicture.asset(imagePath),
            if (imagePath != null) Gap(AppSize.s18.h),
            Text(
              message,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSize.s35.h),
            ButtonWidget(
              radius: AppSize.s14.r,
              text: buttonText,
              onTap: onButtonPressed ?? () => context.pop(),
            ),
            Gap(AppSize.s16.h),
          ],
        ),
      ),
    );
  }
}
