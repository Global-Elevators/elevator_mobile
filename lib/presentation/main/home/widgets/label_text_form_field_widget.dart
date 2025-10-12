import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
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
  final Stream<bool>? isButtonEnabledStream;

  const LabelTextFormFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isOptional = false,
    this.isCenterText = false,
    this.isNotes = false,
    required this.isButtonEnabledStream,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s10.h),
        LabelField(title, isOptional: isOptional),
        Gap(AppSize.s8.h),
        StreamBuilder<bool>(
          stream: isButtonEnabledStream,
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
              TextFromFieldWidget(
                hintText: hintText,
                controller: controller,
                centerText: isCenterText,
                isNotes: isNotes,
                errorText: (snapshot.data ?? true) ? null : Strings.invalidName.tr(),
              ),
        ),
      ],
    );
  }
}
