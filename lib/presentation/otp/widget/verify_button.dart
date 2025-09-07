import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/verified/account_verified_view.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      radius: AppSize.s14.r,
      text: Strings.verifyButton,
      onTap: () =>
          context.push(AccountVerifiedView.accountVerifiedRoute),
    );
  }
}
