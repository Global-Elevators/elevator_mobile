import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarLabel extends StatelessWidget {
  final String label;

  const AppBarLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: getBoldTextStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s28.sp,
      ),
    );
  }
}
