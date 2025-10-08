import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class NumberLabel extends StatelessWidget {
  final String firstThree;
  final String stars;

  const NumberLabel({super.key, required this.firstThree, required this.stars});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: Strings.verifyPhoneMessage.tr(),
        style: getMediumTextStyle(
          color: ColorManager.greyColor,
          fontSize: FontSizeManager.s18,
        ),
        children: [
          TextSpan(
            text: firstThree + stars,
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
