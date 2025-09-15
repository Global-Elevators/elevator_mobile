import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class BuildNameSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController fatherNameController;
  final TextEditingController grandFatherNameController;

  const BuildNameSection({
    super.key,
    required this.firstNameController,
    required this.fatherNameController,
    required this.grandFatherNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelField(Strings.nameLabel),
        Gap(AppSize.s8.h),
        TextFromFieldWidget(
          hintText: Strings.firstName,
          controller: firstNameController,
          prefixIcon: Icon(
            Icons.account_circle_outlined,
            size: AppSize.s30,
            color: ColorManager.primaryColor,
          ),
        ),
        Gap(AppSize.s8.h),
        Row(
          children: [
            Expanded(
              child: TextFromFieldWidget(
                hintText: Strings.fatherName,
                controller: fatherNameController,
              ),
            ),
            Gap(AppSize.s8.w),
            Expanded(
              child: TextFromFieldWidget(
                hintText: Strings.grandfatherName,
                controller: grandFatherNameController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
