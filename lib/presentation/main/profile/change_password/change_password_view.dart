import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/profile/change_password/change_password_viewmodel.dart';
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
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final viewmodel = instance<ChangePasswordViewmodel>();

  @override
  void initState() {
    super.initState();
    updatePasswordValues();
    viewmodel.start();
  }

  @override
  void dispose() {
    super.dispose();
    viewmodel.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void updatePasswordValues() {
    oldPasswordController.addListener(() {
      viewmodel.setOldPassword(oldPasswordController.text);
    });
    newPasswordController.addListener(() {
      viewmodel.setNewPassword(newPasswordController.text);
    });
    confirmPasswordController.addListener(() {
      viewmodel.setConfirmPassword(confirmPasswordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      onlineChild: Scaffold(
        appBar: CustomAppBar(
          title: Strings.changePassword.tr(),
          showBackButton: true,
          popOrGo: true,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<FlowState>(
          stream: viewmodel.outputStateStream,
          builder: (context, snapshot) {
            return snapshot.data?.getStateWidget(
                  context,
                  _getContentWidget(),
                  () {},
                ) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Padding _getContentWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
      child: Column(
        children: [
          PasswordField(
            controller: oldPasswordController,
            hintText: Strings.oldPassword.tr(),
            passwordValidationStream: viewmodel.isOldPasswordValid,
          ),
          Gap(AppSize.s8.h),
          PasswordField(
            controller: newPasswordController,
            hintText: Strings.newPassword.tr(),
            passwordValidationStream: viewmodel.isNewPasswordValid,
          ),
          Gap(AppSize.s8.h),
          PasswordField(
            controller: confirmPasswordController,
            hintText: Strings.confirmPassword.tr(),
            passwordValidationStream: viewmodel.isConfirmPasswordValid,
          ),
          Gap(AppSize.s50.h),
          InputButtonWidget(
            radius: AppSize.s14.r,
            text: Strings.saveChanges.tr(),
            isButtonEnabledStream: viewmodel.areAllInputsValid,
            onTap: () => viewmodel.saveChanges(),
          ),
        ],
      ),
    );
  }
}
