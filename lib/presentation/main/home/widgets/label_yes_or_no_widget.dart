import 'package:elevator/presentation/main/widgets/yes_or_no_button.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LabelYesOrNoWidget extends StatelessWidget {
  final String title;
  final bool condition;
  final void Function() onYesTap;
  final void Function() onNoTap;
  final bool isOptional;

  const LabelYesOrNoWidget({
    super.key,
    required this.title,
    required this.condition,
    required this.onYesTap,
    required this.onNoTap,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        YesOrNoButton(
          condition: condition,
          onYesTap: onYesTap,
          onNoTap: onNoTap,
        ),
      ],
    );
  }
}
