import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          height: AppSize.s50.h,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            border: Border.all(
              color: ColorManager.formFieldsBorderColor,
              width: AppSize.s1.w,
            ),
          ),
          child: Row(
            children: [
              Gap(AppSize.s12.w),
              Image.asset(
                IconAssets.iraqFlag,
                height: AppSize.s20.h,
                width: AppSize.s20.w,
              ),
              Gap(AppSize.s4.w),
              Text(
                "+964",
                style: getRegularTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: AppSize.s18.sp,
                ),
              ),
              Gap(AppSize.s12.w),
            ],
          ),
        ),
        Gap(AppSize.s8.w),
        Expanded(
          child: StreamBuilder<bool>(
            stream: phoneValidationStream,
            builder: (context, snapshot) => TextFromFieldWidget(
              hintText: Strings.phoneNumberTitle.tr(),
              controller: controller,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              errorText: (snapshot.data ?? true)
                  ? null
                  : Strings.invalidPhoneNumber.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
