import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class LabelField extends StatelessWidget {
  final String text;
  final bool isOptional;
  const LabelField(this.text, {this.isOptional = false, super.key});
  @override
  Widget build(BuildContext context) {
    return isOptional
        ? RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: text,
              style: getMediumTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s18,
              ),
              children: [
                TextSpan(
                  text: Strings.optional.tr(),
                  style: getMediumTextStyle(
                    color: ColorManager.greyColor,
                    fontSize: FontSizeManager.s18,
                  ),
                ),
              ],
            ),
          )
        : Text(
            text,
            style: getMediumTextStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeManager.s18,
            ),
          );
  }
}
