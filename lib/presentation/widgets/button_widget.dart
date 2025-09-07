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

  const ButtonWidget({
    super.key,
    required this.radius,
    this.width = double.infinity,
    this.color = ColorManager.blueColor,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s50.h,
        width: width.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
        ),
        child: Center(
          child: Text(
            text,
            style: getMediumTextStyle(
              color: ColorManager.whiteColor,
              fontSize: AppSize.s18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
