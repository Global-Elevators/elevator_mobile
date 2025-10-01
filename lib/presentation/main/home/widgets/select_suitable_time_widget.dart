import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/table_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SelectSuitableTimeWidget extends StatelessWidget {
  final List<DateTime> disabledDays;
  final DateTime focusedDay;

  const SelectSuitableTimeWidget({
    super.key,
    required this.disabledDays,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelField(Strings.selectSuitableTimeToConductTheSiteSurvey),
        Gap(AppSize.s8.h),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s22.r),
            border: Border.all(color: ColorManager.formFieldsBorderColor),
          ),
          child: TableCalendarWidget(
            disabledDays: disabledDays,
            focusedDay: focusedDay,
          ),
        ),
      ],
    );
  }
}
