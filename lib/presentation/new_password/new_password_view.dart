import 'package:elevator/presentation/account_verified/account_verified_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/back_to_button.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NewPasswordView extends StatefulWidget {
  static const String newPasswordRoute = '/new-password';

  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const BackToSignInButton(text: Strings.backSignIn),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(ImageAssets.newPassword),
            Text(
              Strings.enterNewPasswordTitle,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s28.sp,
              ),
            ),
            Text(
              Strings.passwordRequirement,
              style: getRegularTextStyle(
                color: ColorManager.greyColor,
                fontSize: FontSizeManager.s16.sp,
              ),
            ),
            Gap(AppSize.s25.h),
            PasswordField(
              controller: _passwordController,
              hintText: Strings.passwordTitle,
            ),
            Gap(AppSize.s25.h),
            PasswordField(
              controller: _confirmPasswordController,
              hintText: Strings.confirmPassword,
            ),
            Gap(AppSize.s25.h),
            ButtonWidget(
              radius: AppSize.s14,
              text: Strings.continueButton,
              onTap: () => context.go(
                AccountVerifiedView.accountVerifiedRoute,
                extra: "newPassword",
              ),
            ),
            Gap(AppSize.s22.h),
          ],
        ),
      ),
    );
  }
}
