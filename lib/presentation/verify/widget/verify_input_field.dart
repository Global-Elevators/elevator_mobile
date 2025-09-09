import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyInputField extends StatelessWidget {
  const VerifyInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: AppSize.s4.toInt(),
      borderColor: ColorManager.primaryColor,
      showFieldAsBox: true,
      disabledBorderColor: ColorManager.primaryColor,
      fieldWidth: AppSize.s70.h,
      fieldHeight: AppSize.s70.h,
    );
  }
}
