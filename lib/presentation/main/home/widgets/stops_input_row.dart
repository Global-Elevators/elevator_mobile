import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StopsInputRow extends StatelessWidget {
  final TextEditingController controller;
  final num displayedNumber;
  final String leftLabel;
  final String hintText;
  final String rightLabel;

  const StopsInputRow({
    super.key,
    required this.controller,
    required this.displayedNumber,
    this.leftLabel = "G+",
    this.hintText = "x",
    this.rightLabel = "stops",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          leftLabel,
          style: getRegularTextStyle(
            color: ColorManager.greyColor,
            fontSize: FontSizeManager.s18.sp,
          ),
        ),
        Gap(AppSize.s5.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: hintText,
            controller: controller,
            keyboardType: TextInputType.number,
            centerText: true,
          ),
        ),
        Gap(AppSize.s5.w),
        Text(
          " = ${displayedNumber.toString()}",
          style: getRegularTextStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSizeManager.s18.sp,
          ),
        ),
        Gap(AppSize.s5.w),
        Text(
          rightLabel,
          style: getRegularTextStyle(
            color: ColorManager.greyColor,
            fontSize: FontSizeManager.s18.sp,
          ),
        ),
      ],
    );
  }
}
