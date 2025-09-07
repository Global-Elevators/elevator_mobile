import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/text_from_field_widget.dart';
import 'package:flutter/cupertino.dart';
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

  void _showDatePicker(BuildContext context) {
    BottomPicker.date(
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime(1996, 10, 22),
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1960),
      onSubmit: (date) => onDateSelected(date),
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFromFieldWidget(
            hintText: Strings.day,
            controller: dayController,
            onTap: () => _showDatePicker(context),
          ),
        ),
        Gap(AppSize.s5.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: Strings.month,
            controller: monthController,
            onTap: () => _showDatePicker(context),
          ),
        ),
        Gap(AppSize.s5.w),
        Expanded(
          child: TextFromFieldWidget(
            hintText: Strings.year,
            controller: yearController,
            onTap: () => _showDatePicker(context),
          ),
        ),
      ],
    );
  }
}
