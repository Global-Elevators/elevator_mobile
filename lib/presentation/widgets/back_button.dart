import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BackButtonWidget extends StatelessWidget {
  final bool popOrGo;

  const BackButtonWidget({super.key, required this.popOrGo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => popOrGo ? context.pop() : context.push('/notification'),
      child: Stack(
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
          popOrGo
              ? Icon(Icons.arrow_forward_ios, color: ColorManager.primaryColor)
              : SvgPicture.asset(
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
    );
  }
}
