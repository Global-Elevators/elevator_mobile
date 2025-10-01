import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/login/login_viewmodel.dart';
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
    required this.phoneValidationStream,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: AppSize.s55.h,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            border: Border.all(
              color: ColorManager.formFieldsBorderColor,
              width: AppSize.s1.w,
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppSize.s12.w,
              vertical: AppSize.s19.h,
            ),
            child: Row(
              children: [
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
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppSize.s8.w),
        Expanded(
          child: StreamBuilder<bool>(
            stream: phoneValidationStream,
            builder: (context, snapshot) => TextFromFieldWidget(
              hintText: Strings.phoneNumberTitle,
              controller: controller,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              errorText: (snapshot.data ?? true)
                  ? null
                  : Strings.invalidPhoneNumber,
            ),
          ),
        ),
      ],
    );
  }
}
