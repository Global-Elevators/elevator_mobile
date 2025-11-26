import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegistrationBox extends StatelessWidget {
  final NextAppointmentDataModel data;

  const RegistrationBox(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s130.h,
      decoration: BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.circular(AppSize.s22.r),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppSize.s16.w,
          vertical: AppSize.s16.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.nextAppointment.tr(),
                  style: getMediumTextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: FontSizeManager.s18.sp,
                  ),
                ),
                Text(
                  Strings.elevatorMaintenance.tr(),
                  style: getMediumTextStyle(
                    color: ColorManager.lightBlueColor,
                    fontSize: FontSizeManager.s16.sp,
                  ),
                ),
                Gap(AppSize.s22.h),
                Text(
                  data.scheduleDate,
                  style: getMediumTextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: FontSizeManager.s18.sp,
                  ),
                ),
              ],
            ),
            ClipRRect(
              child: Image.asset(
                ImageAssets.blueLine,
                height: AppSize.s150.h,
                width: AppSize.s105.w,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Text(
                data.daysLeft,
                style: getMediumTextStyle(
                  color: ColorManager.semiLightBlueColor,
                  fontSize: FontSizeManager.s16.sp,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
