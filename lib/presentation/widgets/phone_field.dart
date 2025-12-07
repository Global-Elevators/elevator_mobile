import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final Stream<bool>? phoneValidationStream;

  const PhoneField({
    super.key,
    required this.controller,
    this.phoneValidationStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: phoneValidationStream,
      builder: (context, snapshot) {
        final hasError = !(snapshot.data ?? true);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppSize.s60.h,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(AppSize.s14.r),
                border: Border.all(
                  color: hasError
                      ? ColorManager.errorColor
                      : ColorManager.formFieldsBorderColor,
                  width: AppSize.s1.w,
                ),
              ),
              child: Row(
                children: [
                  Gap(AppSize.s12.w),
                  Image.asset(
                    IconAssets.iraqFlag,
                    height: AppSize.s25.h,
                    width: AppSize.s25.w,
                  ),
                  Gap(AppSize.s8.w),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 4.h),
                    child: Text(
                      "+964",
                      style: getRegularTextStyle(
                        color: ColorManager.primaryColor,
                        fontSize: AppSize.s18.sp,
                      ),
                    ),
                  ),
                  Gap(AppSize.s12.w),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: Strings.phoneNumberTitle.tr(),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: getRegularTextStyle(
                        color: ColorManager.primaryColor,
                        fontSize: AppSize.s18.sp,
                      ),
                    ),
                  ),
                  Gap(AppSize.s12.w),
                ],
              ),
            ),
            if (hasError) ...[
              Gap(AppSize.s8.h),
              Padding(
                padding: EdgeInsets.only(left: AppSize.s12.w),
                child: Text(
                  Strings.invalidPhoneNumber.tr(),
                  style: getRegularTextStyle(
                    color: ColorManager.errorColor,
                    fontSize: AppSize.s12.sp,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
