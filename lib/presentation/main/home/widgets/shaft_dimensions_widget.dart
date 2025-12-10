import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShaftDimensionsWidget extends StatelessWidget {
  final TextEditingController widthController;
  final TextEditingController depthController;

  const ShaftDimensionsWidget({
    super.key,
    required this.widthController,
    required this.depthController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSize.s25.h),
        LabelField(Strings.shaftDimensions.tr(), isOptional: true),
        Gap(AppSize.s8.h),
        theTwoFormFields(
          widthController,
          depthController,
          Strings.widthCm.tr(),
          Strings.depthCm.tr(),
        ),
      ],
    );
  }

  Row theTwoFormFields(
    firstController,
    secondController,
    firstText,
    secondText,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextFromFieldWidget(
            hintText: firstText,
            controller: firstController,
            keyboardType: TextInputType.number,
            centerText: true,
          ),
        ),
        Gap(AppSize.s8.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: secondText,
            controller: secondController,
            keyboardType: TextInputType.number,
            centerText: true,
          ),
        ),
      ],
    );
  }
}
