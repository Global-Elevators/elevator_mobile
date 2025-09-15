import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OptionalText extends StatelessWidget {
  final String name;
  const OptionalText(this.name,{super.key,});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: name,
        style: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s18,
        ),
        children: [
          TextSpan(
            text: Strings.optional,
            style: getMediumTextStyle(
              color: ColorManager.greyColor,
              fontSize: FontSizeManager.s18,
            ),
          ),
        ],
      ),
    );
  }
}
