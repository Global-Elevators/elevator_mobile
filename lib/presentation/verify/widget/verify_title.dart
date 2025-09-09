import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class VerifyTitle extends StatelessWidget {
  const VerifyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.verifyPhoneTitle,
      style: getBoldTextStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s28,
      ),
    );
  }
}
