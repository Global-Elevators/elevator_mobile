import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class YesOrNoButton extends StatelessWidget {
  final bool condition;
  final Function() onYesTap;
  final Function() onNoTap;

  const YesOrNoButton({
    super.key,
    required this.condition,
    required this.onYesTap,
    required this.onNoTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s55.h,
      child: Row(
        children: [
          yesButton(),
          Gap(AppSize.s8.w),
          noButton(),
        ],
      ),
    );
  }

  Expanded noButton() {
    return Expanded(
          child: InputButtonWidget(
            radius: AppSize.s14.r,
            text: Strings.no,
            onTap: onNoTap,
            color: condition
                ? ColorManager.primaryColor
                : ColorManager.whiteColor,
            textColor: condition
                ? ColorManager.whiteColor
                : ColorManager.greyColor,
          ),
        );
  }

  Expanded yesButton() {
    return Expanded(
          child: InputButtonWidget(
            radius: AppSize.s14.r,
            text: Strings.yes,
            onTap: onYesTap,
            color: condition
                ? ColorManager.whiteColor
                : ColorManager.primaryColor,
            textColor: condition
                ? ColorManager.primaryColor
                : ColorManager.whiteColor,
          ),
        );
  }
}
