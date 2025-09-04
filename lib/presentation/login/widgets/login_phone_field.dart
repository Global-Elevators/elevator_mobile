import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const LoginPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSize.s60.w,
          height: AppSize.s40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8.r),
            border: Border.all(
              color: ColorManager.greyColor,
              width: AppSize.s1_5.w,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "+964",
            style: getRegularTextStyle(
              color: ColorManager.blueColor,
              fontSize: AppSize.s18.sp,
            ),
          ),
        ),
        SizedBox(width: AppSize.s8.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: Strings.phoneNumberTitle,
            controller: controller,
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}
