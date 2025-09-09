import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/verify/verify_view.dart';
import 'package:elevator/presentation/widgets/back_to_button.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/phone_field.dart';

class ForgetPasswordView extends StatefulWidget {
  static const String forgetPasswordRoute = '/forget-password';

  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BackToButton(text: Strings.signInButton),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Gap(AppSize.s8.h),
            Text(
              Strings.forgetPasswordMessage,
              style: getMediumTextStyle(
                color: ColorManager.greyColor,
                fontSize: AppSize.s16,
              ),
            ),
            Gap(AppSize.s40.h),
            PhoneField(controller: _phoneController),
            Gap(AppSize.s25.h),
            ButtonWidget(
              radius: AppSize.s14,
              text: Strings.getCodeButton,
              onTap: () => context.go(
                VerifyView.verifyRoute,
                extra: [
                  _phoneController.text,
                  "forget-password"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
