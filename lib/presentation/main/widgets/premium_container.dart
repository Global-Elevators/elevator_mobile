import 'package:elevator/presentation/main/widgets/premium_button.dart';
import 'package:elevator/presentation/main/widgets/sos_button.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/action_or_cancel_button.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class PremiumContainer extends StatefulWidget {
  final bool isPremium;

  const PremiumContainer(this.isPremium, {super.key});

  @override
  State<PremiumContainer> createState() => _PremiumContainerState();
}

class _PremiumContainerState extends State<PremiumContainer> {
  DateTime focusedDay = DateTime.now();
  final List<DateTime> disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSize.s8.r),
        child: Column(
          children: [
            SosButton(widget.isPremium),
            Gap(AppSize.s16.h),
            SizedBox(
              height: AppSize.s120.h,
              child: Row(
                children: [
                  PremiumButton(
                    title: Strings.reportBreakDown,
                    imageAsset: ImageAssets.maintenance,
                    isPremium: widget.isPremium,
                    onTap: () {},
                  ),
                  Gap(AppSize.s8.w),
                  PremiumButton(
                    title: Strings.requestVisitRescheduling,
                    imageAsset: ImageAssets.calendar,
                    isPremium: widget.isPremium,
                    onTap: () => showModelOfRequestVisitRescheduling(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showModelOfRequestVisitRescheduling(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s50.r),
            topRight: Radius.circular(AppSize.s50.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: AppSize.s30.h,
            end: AppSize.s16.w,
            start: AppSize.s16.w,
          ),
          child: Column(
            children: [
              Text(
                Strings.requestVisitRescheduling,
                style: getBoldTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s22.sp,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                Strings.chooseVisitDate,
                style: getMediumTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              tableCalendarWidget(),
              Gap(AppSize.s16.h),
              ActionOrCancelButton(Strings.request, () {
                context.pop();
                showModelOfSendRequest(context);
              }, actionColor: ColorManager.primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  StatefulBuilder tableCalendarWidget() {
    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setState) =>
              TableCalendar(
                focusedDay: focusedDay,
                enabledDayPredicate: (day) {
                  for (DateTime disabled in disabledDays) {
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
                    // borderRadius: BorderRadius.circular(AppSize.s8.r),
                  ),
                ),
                firstDay: DateTime.utc(2010, 12, 31),
                lastDay: DateTime.utc(2025, 12, 31),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    this.focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) => isSameDay(focusedDay, day),
                availableGestures: AvailableGestures.all,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: getMediumTextStyle(
                    color: ColorManager.primaryColor,
                    fontSize: FontSizeManager.s22.sp,
                  ),
                ),
              ),
    );
  }

  Future<dynamic> showModelOfSendRequest(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => Container(
        width: double.infinity.w,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s50.r),
            topRight: Radius.circular(AppSize.s50.r),
          ),
        ),
        padding: EdgeInsetsDirectional.only(
          top: AppSize.s30.h,
          end: AppSize.s16.w,
          start: AppSize.s16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(ImageAssets.successfully),
            Gap(AppSize.s18.h),
            Text(
              Strings.requestVisitReschedulingMessage,
              style: getBoldTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s22.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSize.s35.h),
            ButtonWidget(
              radius: AppSize.s14.r,
              text: Strings.done,
              onTap: () => context.pop(),
            ),
            Gap(AppSize.s16.h),
          ],
        ),
      ),
    );
  }
}
