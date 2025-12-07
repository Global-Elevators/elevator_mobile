import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class VerifyInputField extends StatelessWidget {
  final void Function(String)? onSubmit;

  const VerifyInputField(this.onSubmit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: OtpTextField(
        numberOfFields: AppSize.s4.toInt(),
        borderColor: ColorManager.primaryColor,
        showFieldAsBox: true,
        disabledBorderColor: ColorManager.primaryColor,
        fieldWidth: AppSize.s70.h,
        fieldHeight: AppSize.s70.h,
        filled: true,
        fillColor: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(AppSize.s16.r),
        textStyle: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s26.sp,
        ),
        enabledBorderColor: ColorManager.formFieldsBorderColor,
        cursorColor: ColorManager.greyColor,
        autoFocus: true,
        borderWidth: AppSize.s1.w,
        onSubmit: onSubmit,
      ),
    );
  }
}
