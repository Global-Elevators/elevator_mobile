import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/input_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActionOrCancelButton extends StatelessWidget {
  final String actionText;
  final void Function()? actionOnTap;
  final Color actionColor;

  const ActionOrCancelButton(
    this.actionText,
    this.actionOnTap, {
    super.key,
    required this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InputButtonWidget(
          radius: AppSize.s14.r,
          text: actionText,
          onTap: actionOnTap,
          width: AppSize.s185.w,
          color: actionColor,
        ),
        Spacer(),
        InputButtonWidget(
          radius: AppSize.s14.r,
          text: Strings.cancel,
          onTap: () => context.pop(),
          width: AppSize.s185.w,
          color: ColorManager.whiteColor,
          textColor: ColorManager.primaryColor,
        ),
      ],
    );
  }
}
