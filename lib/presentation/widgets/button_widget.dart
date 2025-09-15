import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final double radius, width;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color textColor;

  const ButtonWidget({
    super.key,
    required this.radius,
    this.width = double.infinity,
    this.color = ColorManager.primaryColor,
    required this.text,
    required this.onTap,
    this.textColor = ColorManager.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s55.h,
        width: width.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: ColorManager.formFieldsBorderColor,
            width: AppSize.s1.w,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: getMediumTextStyle(
              color: textColor,
              fontSize: AppSize.s18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
