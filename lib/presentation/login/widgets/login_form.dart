import 'package:elevator/presentation/forget_password/forget_password_view.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:elevator/presentation/login/widgets/login_texts.dart';
import 'package:elevator/presentation/register/register_view.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor.withOpacity(0.9),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s24.r),
        ),
      ),
      child: Padding(
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
              const InputLabel(title: Strings.phoneNumberTitle),
              Gap(AppSize.s8.h),
              PhoneField(controller: phoneController),
              Gap(AppSize.s16.h),
              const InputLabel(title: Strings.passwordTitle),
              Gap(AppSize.s8.h),
              PasswordField(controller: passwordController, hintText: Strings.passwordTitle),
              Gap(AppSize.s28.h),
              ButtonWidget(
                radius: AppSize.s14,
                text: Strings.signInButton,
                onTap: () {},
              ),

              Gap(AppSize.s25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Strings.noAccountMessage),
                  TextButtonWidget(
                    Strings.signUpButton,
                    ColorManager.blueColor,
                    AppSize.s18.sp,
                    () {
                      context.push(RegisterView.registerRoute);
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: TextButtonWidget(
                  Strings.forgetPassword,
                  ColorManager.blueColor,
                  AppSize.s18,
                  () => context.push(ForgetPasswordView.forgetPasswordRoute),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
