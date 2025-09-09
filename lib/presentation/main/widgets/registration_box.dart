import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationBox extends StatelessWidget {
  const RegistrationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s130.h,
      decoration: BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.circular(AppSize.s22.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppSize.s16.w,
              top: AppSize.s16.h,
              bottom: AppSize.s16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.nextAppointment,
                  style: getMediumTextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: FontSizeManager.s18.sp,
                  ),
                ),
                Text(
                  Strings.elevatorMaintenance,
                  style: getMediumTextStyle(
                    color: ColorManager.lightBlueColor,
                    fontSize: FontSizeManager.s16.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  Strings.appointmentDate,
                  style: getMediumTextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: FontSizeManager.s18.sp,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            child: Image.asset(
              ImageAssets.blueLine,
              height: AppSize.s150.h,
              width: AppSize.s105.w,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppSize.s16.h),
            child: Text(
              Strings.daysLeft,
              style: getMediumTextStyle(
                color: ColorManager.semiLightBlueColor,
                fontSize: FontSizeManager.s16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
