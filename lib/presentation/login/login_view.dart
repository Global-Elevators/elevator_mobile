import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/login/login_viewmodel.dart';
import 'package:elevator/presentation/login/widgets/logo_background.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/verify/verify_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/login_form.dart';
import 'widgets/login_language_button.dart';
import 'widgets/login_logo.dart';

class LoginView extends StatefulWidget {
  static const String loginRoute = "/login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _loginViewModel.dispose();
  }

  _bind() {
    _loginViewModel.start();
    updatingPhoneAndPasswordValues();
    isCredentialsCorrect();
  }

  void updatingPhoneAndPasswordValues() {
    _phoneController.addListener(
      () => _loginViewModel.setUserPhone(_phoneController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setUserPassword(_passwordController.text),
    );
  }

  void isCredentialsCorrect() {
    _loginViewModel.isUserLoggedInSuccessfullyController.stream.listen((
      isUserLoggedInSuccessfully,
    ) {
      if (isUserLoggedInSuccessfully) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.go(
            VerifyView.verifyRoute,
            extra: [_phoneController.text, "login"],
          );
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outputStateStream,
        builder: (context, snapshot) {
          return snapshot.data?.getStateWidget(
                context,
                _getContentWidget(),
                () {},
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  Stack _getContentWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        const LoginBackground(),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const LoginLanguageButton(),
                const LoginLogo(),
                Gap(AppSize.s20.h),
                LoginForm(
                  phoneController: _phoneController,
                  passwordController: _passwordController,
                  phoneValidationStream: _loginViewModel.outIsPhoneValid,
                  passwordValidationStream: _loginViewModel.outIsPasswordValid,
                  onTap: () => _loginViewModel.login(),
                  isButtonEnabledStream: _loginViewModel.outAreAllDataValid,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
