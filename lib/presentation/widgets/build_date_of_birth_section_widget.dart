import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/register/widgets/date_of_birth_row.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum DateOfBirthType { Day, Month, Year }

class BuildDateOfBirthSectionWidget extends StatelessWidget {
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;
  final Function(DateTime) onDateSelected;

  const BuildDateOfBirthSectionWidget({
    super.key,
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.dateOfBirth.tr()),
        Gap(AppSize.s14.h),
        Row(
          children: DateOfBirthType.values.map((type) {
            return Expanded(
              child: Text(
                type.name,
                style: getMediumTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
              ),
            );
          }).toList(),
        ),
        DateOfBirthRow(
          dayController: dayController,
          monthController: monthController,
          yearController: yearController,
          onDateSelected: onDateSelected,
        ),
      ],
    );
  }
}
