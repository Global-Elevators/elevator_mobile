import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgetPasswordBody extends StatelessWidget {
  final TextEditingController phoneController;
  final void Function() onGetCode;
  final Stream<bool>? isButtonEnabledStream;

  const ForgetPasswordBody({
    super.key,
    required this.phoneController,
    required this.onGetCode,
    required this.isButtonEnabledStream,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(ImageAssets.password),
          Gap(AppSize.s25.h),
          Text(
            Strings.forgetPasswordTitle,
            style: getBoldTextStyle(
              color: ColorManager.primaryColor,
              fontSize: AppSize.s24,
            ),
          ),
          Text(
            Strings.forgetPasswordMessage,
            style: getMediumTextStyle(
              color: ColorManager.greyColor,
              fontSize: AppSize.s16,
            ),
          ),
          Gap(AppSize.s40.h),
          PhoneField(controller: phoneController, phoneValidationStream: isButtonEnabledStream),
          Gap(AppSize.s25.h),
          InputButtonWidget(
            radius: AppSize.s14,
            text: Strings.getCodeButton,
            onTap: onGetCode,
            isButtonEnabledStream: isButtonEnabledStream,
          ),
          Gap(AppSize.s22.h),
        ],
      ),
    );
  }
}
