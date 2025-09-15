import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableCalendarWidget extends StatefulWidget {
  final List<DateTime> disabledDays;
  final DateTime focusedDay;
  final Function(DateTime, DateTime)? onDaySelected;

  const TableCalendarWidget({
    super.key,
    required this.disabledDays,
    required this.focusedDay,
    this.onDaySelected,
  });

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      enabledDayPredicate: (day) {
        for (DateTime disabled in widget.disabledDays) {
          if (isSameDay(disabled, day)) {
            return false;
          }
        }
        return true;
      },
      rowHeight: AppSize.s40.h,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: ColorManager.greyColor,
          shape: BoxShape.rectangle,
          border: Border.all(color: ColorManager.greyColor),
          borderRadius: BorderRadius.circular(AppSize.s8.r),
        ),
        selectedDecoration: BoxDecoration(
          color: ColorManager.primaryColor,
          shape: BoxShape.rectangle,
          border: Border.all(color: ColorManager.greyColor),
        ),
      ),
      firstDay: DateTime.utc(2010, 12, 31),
      lastDay: DateTime.utc(2025, 12, 31),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
        widget.onDaySelected?.call(selectedDay, focusedDay);
      },
      selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
      availableGestures: AvailableGestures.all,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: getMediumTextStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s22.sp,
        ),
      ),
    );
  }
}
