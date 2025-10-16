import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/text_button_widget.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DateOfBirthRow extends StatelessWidget {
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;
  final void Function(DateTime) onDateSelected;

  const DateOfBirthRow({
    super.key,
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.onDateSelected,
  });

  void _openDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _DatePickerBottomSheet(
        onDateSelected: (selectedDate) {
          dayController.text = selectedDate.day.toString().padLeft(2, '0');
          monthController.text = selectedDate.month.toString().padLeft(2, '0');
          yearController.text = selectedDate.year.toString();
          onDateSelected(selectedDate);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DateInputField(
          label: Strings.day.tr(),
          controller: dayController,
          onTap: () => _openDatePicker(context),
        ),
        const SizedBox(width: 8),
        _DateInputField(
          label: Strings.month.tr(),
          controller: monthController,
          onTap: () => _openDatePicker(context),
        ),
        const SizedBox(width: 8),
        _DateInputField(
          label: Strings.year.tr(),
          controller: yearController,
          onTap: () => _openDatePicker(context),
        ),
      ],
    );
  }
}

class _DatePickerBottomSheet extends StatefulWidget {
  final void Function(DateTime) onDateSelected;

  const _DatePickerBottomSheet({required this.onDateSelected});

  @override
  State<_DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<_DatePickerBottomSheet> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s370.h,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p12,
      ),
      child: Column(
        children: [
          Text(
            _formattedDate(_selectedDate),
            style: getMediumTextStyle(
              color: ColorManager.blackColor,
              fontSize: FontSizeManager.s26.sp,
            ),
          ),
          const Divider(),
          SizedBox(
            height: AppSize.s205.h,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(1960),
              onDateTimeChanged: (newDate) {
                setState(() => _selectedDate = newDate);
              },
            ),
          ),
          Gap(AppSize.s16.h),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  String _formattedDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: AppSize.s55.h,
      child: Row(
        children: [
          Expanded(
            child: TextButtonWidget(
              Strings.cancel.tr(),
              ColorManager.greyColor,
              AppSize.s18.sp,
              () => Navigator.pop(context),
            ),
          ),
          Gap(AppSize.s20.w),
          Expanded(
            child: ButtonWidget(
              radius: AppSize.s18.sp,
              text: Strings.select.tr(),
              onTap: () {
                widget.onDateSelected(_selectedDate);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateInputField({
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFromFieldWidget(
        hintText: label,
        controller: controller,
        readOnly: true,
        onTap: onTap,
      ),
    );
  }
}
