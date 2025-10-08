import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/account_verified/account_verified_view.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/new_password/new_password_viewmodel.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:elevator/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NewPasswordView extends StatefulWidget {
  static const String newPasswordRoute = '/new-password';
  final String token;

  const NewPasswordView(this.token, {super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _viewModel = instance<NewPasswordViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.start();
    _viewModel.setUserToken(widget.token);
    updatingPasswordAndConfirmPasswordValues();
    isPasswordAndConfirmPasswordCorrect();
  }

  void updatingPasswordAndConfirmPasswordValues() {
    _passwordController.addListener(
      () => _viewModel.setUserPassword(_passwordController.text),
    );
    _confirmPasswordController.addListener(
      () => _viewModel.setUserConfirmPassword(_confirmPasswordController.text),
    );
  }

  void isPasswordAndConfirmPasswordCorrect() {
    _viewModel.didUserEnterPasswordAndConfirmPasswordController.stream.listen((
      didUserEnterPasswordAndConfirmPassword,
    ) {
      if (didUserEnterPasswordAndConfirmPassword) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.go(
            AccountVerifiedView.accountVerifiedRoute,
            extra: "newPassword",
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // title: const BackToSignInButton(text: Strings.backSignIn),
        // title: const Text(Strings.backSignIn),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputStateStream,
        builder: (context, snapshot) =>
            snapshot.data?.getStateWidget(
              context,
              _getCurrentWidget(context),
              () {},
            ) ??
            _getCurrentWidget(context),
      ),
    );
  }

  Padding _getCurrentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(ImageAssets.newPassword),
          Text(
            Strings.enterNewPasswordTitle.tr(),
            style: getBoldTextStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeManager.s28.sp,
            ),
          ),
          Text(
            Strings.passwordRequirement.tr(),
            style: getRegularTextStyle(
              color: ColorManager.greyColor,
              fontSize: FontSizeManager.s16.sp,
            ),
          ),
          Gap(AppSize.s25.h),
          PasswordField(
            controller: _passwordController,
            hintText: Strings.passwordTitle.tr(),
            passwordValidationStream: _viewModel.outIsPasswordValid,
          ),
          Gap(AppSize.s25.h),
          PasswordField(
            controller: _confirmPasswordController,
            hintText: Strings.confirmPassword.tr(),
            passwordValidationStream: _viewModel.outIsConfirmPasswordValid,
          ),
          Gap(AppSize.s25.h),
          InputButtonWidget(
            radius: AppSize.s14,
            text: Strings.continueButton.tr(),
            onTap: () => _viewModel.resetPassword(),
            isButtonEnabledStream: _viewModel.outAreAllDataValid,
          ),
          Gap(AppSize.s22.h),
        ],
      ),
    );
  }
}

//  context.go(
//               AccountVerifiedView.accountVerifiedRoute,
//               extra: "newPassword",
//             )
