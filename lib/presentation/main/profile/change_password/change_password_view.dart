import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChangePasswordView extends StatefulWidget {
  static const String routeName = '/change-password';

  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController  = TextEditingController();
  TextEditingController confirmPasswordController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.changePassword,
        showBackButton: true,
        popOrGo: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          children: [
            PasswordField(
              controller: oldPasswordController,
              hintText: Strings.oldPassword,
              passwordValidationStream: null,
            ),
            Gap(AppSize.s10.h),
            PasswordField(
              controller: newPasswordController,
              hintText: Strings.newPassword,
              passwordValidationStream: null,
            ),
            Gap(AppSize.s10.h),
            PasswordField(
              controller: confirmPasswordController,
              hintText: Strings.confirmPassword,
              passwordValidationStream: null,
            ),
            Gap(AppSize.s50.h),
            InputButtonWidget(
              radius: AppSize.s14.r,
              text: Strings.saveChanges,
              isButtonEnabledStream: null,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
