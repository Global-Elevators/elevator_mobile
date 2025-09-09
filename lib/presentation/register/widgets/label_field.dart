import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class LabelField extends StatelessWidget {
  final String text;
  const LabelField(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getMediumTextStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s18,
      ),
    );
  }
}