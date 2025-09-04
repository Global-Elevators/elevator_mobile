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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LoginBackground(),
          SafeArea(
            child: Column(
              children: [
                const LoginLanguageButton(),
                const LoginLogo(),
                Gap(AppSize.s20.h),
                Expanded(
                  child: LoginForm(
                    phoneController: phoneController,
                    passwordController: passwordController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
