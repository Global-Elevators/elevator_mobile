import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendCode extends StatelessWidget {
  final int seconds;
  final Function() onTap;

  const ResendCode({super.key, required this.seconds, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        recognizer: TapGestureRecognizer()..onTap = onTap,
        text: Strings.resendCode,
        style: getMediumTextStyle(
          color: seconds > 0
              ? ColorManager.greyColor
              : ColorManager.primaryColor,
          fontSize: FontSizeManager.s18,
        ),
        children: [
          TextSpan(
            text: seconds.toString().padLeft(2, '0'),
            style: getMediumTextStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeManager.s18,
            ),
          ),
        ],
      ),
    );
  }
}
