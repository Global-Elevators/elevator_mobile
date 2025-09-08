import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendCode extends StatelessWidget {
  final int seconds;

  const ResendCode({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () => seconds > 0 ? null : debugPrint("Moamen"),
        text: Strings.resendCode,
        style: getMediumTextStyle(
          color: seconds > 0
              ? ColorManager.greyColor
              : ColorManager.blueColor,
          fontSize: FontSizeManager.s18,
        ),
        children: [
          TextSpan(
            text: seconds.toString().padLeft(2, '0'),
            style: getMediumTextStyle(
              color: ColorManager.blueColor,
              fontSize: FontSizeManager.s18,
            ),
          ),
        ],
      ),
    );
  }
}
