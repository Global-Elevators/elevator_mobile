import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LabelTextFormFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool isOptional;
  final bool isCenterText;
  final bool isNotes;

  const LabelTextFormFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isOptional = false,
    this.isCenterText = false,
    this.isNotes = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s10.h),
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: hintText,
          controller: controller,
          centerText: isCenterText,
          isNotes: isNotes,
        ),
      ],
    );
  }
}
