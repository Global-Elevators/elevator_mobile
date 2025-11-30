import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/home_viewmodel.dart';
import 'package:elevator/presentation/main/home/report_break_down/report_break_down_view.dart';
import 'package:elevator/presentation/main/widgets/premium_button.dart';
import 'package:elevator/presentation/main/widgets/sos_button.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/action_or_cancel_button.dart';
import 'package:elevator/presentation/widgets/custom_bottom_sheet.dart';
import 'package:elevator/presentation/widgets/table_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PremiumContainer extends StatefulWidget {
  final bool isPremium;
  final void Function()? actionOnTap;

  const PremiumContainer(this.isPremium, this.actionOnTap, {super.key});

  @override
  State<PremiumContainer> createState() => _PremiumContainerState();
}

class _PremiumContainerState extends State<PremiumContainer> {
  List<DateTime> disabledDays = [
    DateTime.utc(2025, 9, 15),
    DateTime.utc(2025, 9, 18),
    DateTime.utc(2025, 9, 20),
  ];
  DateTime? focusedDay;
  String _selectedDay = "";
  final viewmodel = instance<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: viewmodel.outputStateStream,
      builder: (context, snapshot) {
        return snapshot.data?.getStateWidget(
              context,
              _getContentWidget(context),
              () {},
            ) ??
            _getContentWidget(context);
      },
    );
  }

  Container _getContentWidget(BuildContext context) {
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
            SosButton(widget.isPremium, widget.actionOnTap),
            Gap(AppSize.s16.h),
            SizedBox(
              height: AppSize.s120.h,
              child: Row(
                children: [
                  PremiumButton(
                    title: Strings.reportBreakDown.tr(),
                    imageAsset: ImageAssets.maintenance,
                    isPremium: widget.isPremium,
                    onTap: () =>
                        context.push(ReportBreakDownView.reportBreakDownRoute),
                  ),
                  Gap(AppSize.s8.w),
                  PremiumButton(
                    title: Strings.requestVisitRescheduling.tr(),
                    imageAsset: IconAssets.calendar,
                    isPremium: widget.isPremium,
                    onTap: () => showModelOfRequestVisitRescheduling(context, (
                      selectedDay,
                      newFocusedDay,
                    ) {
                      setState(() {
                        focusedDay = newFocusedDay;
                        _selectedDay =
                            "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";
                      });
                      viewmodel.setScheduleDate(_selectedDay);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showModelOfRequestVisitRescheduling(
    BuildContext context,
    dynamic Function(DateTime, DateTime)? onDaySelected,
  ) {
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
                Strings.requestVisitRescheduling.tr(),
                style: getBoldTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s22.sp,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                Strings.chooseVisitDate.tr(),
                style: getMediumTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              TableCalendarWidget(
                disabledDays: disabledDays,
                focusedDay: DateTime.now(),
                onDaySelected: onDaySelected,
              ),
              Gap(AppSize.s16.h),
              ActionOrCancelButton(Strings.request.tr(), () {
                viewmodel.requestVisitRescheduling();
                context.pop();
                CustomBottomSheet.show(
                  context: context,
                  imagePath: ImageAssets.successfully,
                  message: Strings.requestVisitReschedulingMessage.tr(),
                  buttonText: Strings.done.tr(),
                );
              }, actionColor: ColorManager.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
