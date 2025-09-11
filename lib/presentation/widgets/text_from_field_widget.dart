import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFromFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final void Function()? onTap;

  const TextFromFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s55.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        /// TODO: Change the style of the text
        style: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: AppSize.s20.sp,
        ),
        enabled: enabled,
        onFieldSubmitted: onFieldSubmitted,
        /// TODO: Change the cursor color
        cursorColor: ColorManager.primaryColor,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: ColorManager.whiteColor,
          hintStyle: getRegularTextStyle(
            color: Color(0xff777777),
            fontSize: AppSize.s16.sp,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            borderSide: BorderSide(
              color: ColorManager.formFieldsBorderColor,
              width: AppSize.s1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            borderSide: BorderSide(
              color: ColorManager.primaryColor,
              width: AppSize.s1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
            borderSide: BorderSide(color: ColorManager.errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s20.r),
            borderSide: BorderSide(
              color: ColorManager.errorColor,
              width: AppSize.s1.w,
            ),
          ),
        ),
      ),
    );
  }
}
