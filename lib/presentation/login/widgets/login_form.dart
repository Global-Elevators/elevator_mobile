import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/forget_password/forget_password_view.dart';
import 'package:elevator/presentation/login/widgets/login_texts.dart';
import 'package:elevator/presentation/register/register_view.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:elevator/presentation/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final Stream<bool>? phoneValidationStream;
  final Stream<bool>? passwordValidationStream;
  final void Function()? onTap;
  final Stream<bool>? isButtonEnabledStream;

  const LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.phoneValidationStream,
    required this.passwordValidationStream,
    this.onTap,
    this.isButtonEnabledStream,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s16.w,
        vertical: AppSize.s22.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeTitle(),
            const WelcomeMessage(),
            Gap(AppSize.s34.h),
            InputLabel(title: Strings.phoneNumberTitle.tr()),
            PhoneField(
              controller: phoneController,
              phoneValidationStream: phoneValidationStream,
            ),
            Gap(AppSize.s20.h),
            InputLabel(title: Strings.passwordTitle.tr()),
            PasswordField(
              controller: passwordController,
              hintText: Strings.passwordTitle.tr(),
              passwordValidationStream: passwordValidationStream,
            ),
            InputButtonWidget(
              radius: AppSize.s14,
              text: Strings.signInButton.tr(),
              onTap: onTap,
              isButtonEnabledStream: isButtonEnabledStream,
            ),
            Gap(AppSize.s25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.noAccountMessage.tr(),
                  style: getRegularTextStyle(
                    color: ColorManager.greyColor,
                    fontSize: FontSizeManager.s18.sp,
                  ),
                ),
                TextButtonWidget(
                  Strings.signUpButton.tr(),
                  ColorManager.primaryColor,
                  AppSize.s18.sp,
                  () => context.push(RegisterView.registerRoute),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: TextButtonWidget(
                Strings.forgetPassword.tr(),
                ColorManager.primaryColor,
                AppSize.s18,
                () => context.go(ForgetPasswordView.forgetPasswordRoute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
