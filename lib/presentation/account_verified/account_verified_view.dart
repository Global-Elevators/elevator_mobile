import 'package:elevator/presentation/login/login_view.dart';
import 'package:elevator/presentation/main/main_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AccountVerifiedView extends StatefulWidget {
  final String title;
  static const String accountVerifiedRoute = '/accountVerified';

  const AccountVerifiedView(this.title, {super.key});

  @override
  State<AccountVerifiedView> createState() => _AccountVerifiedViewState();
}

class _AccountVerifiedViewState extends State<AccountVerifiedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.verification,
              ),
              Gap(AppSize.s25.h),
              Text(
                textAlign: TextAlign.center,
                widget.title == "register"
                    ? Strings.accountVerifiedTitle
                    : Strings.passwordChangedTitle,
                style: getBoldTextStyle(
                  color: ColorManager.blueColor,
                  fontSize: FontSizeManager.s28.sp,
                ),
              ),
              Text(
                widget.title == "register"
                    ? Strings.accountVerifiedMessage
                    : Strings.passwordChangedMessage,
                style: getMediumTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
              ),
              Gap(AppSize.s40.h),
              ButtonWidget(
                radius: AppSize.s14,
                text: widget.title == "register"
                    ? Strings.doneButton
                    : Strings.signInButton,
                onTap: () => context.go(
                  widget.title == "register"
                      ? MainView.mainRoute
                      : LoginView.loginRoute,
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
