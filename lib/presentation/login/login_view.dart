import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/login/login_viewmodel.dart';
import 'package:elevator/presentation/login/widgets/logo_background.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _loginViewModel.dispose();
  }

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  _bind() {
    _loginViewModel.start();
    _phoneController.addListener(
      () => _loginViewModel.setUserPhone(_phoneController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setUserPassword(_passwordController.text),
    );
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
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
      ),
    );
  }
}
