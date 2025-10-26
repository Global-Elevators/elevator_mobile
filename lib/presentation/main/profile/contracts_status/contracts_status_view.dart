import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ContractsStatusView extends StatefulWidget {
  static const String routeName = '/contracts-status';

  const ContractsStatusView({super.key});

  @override
  State<ContractsStatusView> createState() => _ContractsStatusViewState();
}

class _ContractsStatusViewState extends State<ContractsStatusView> {
  final steps = [
    {"title": "Awaiting Drawing", "date": "09:30 AM, 9 May 2025", "done": true},
    {"title": "Design Approval", "date": "09:30 AM, 9 May 2025", "done": true},
    {
      "title": "Under Manufacturing",
      "date": "09:30 AM, 9 May 2025",
      "done": true,
    },
    {"title": "Under Shipping", "date": "09:30 AM, 9 May 2025", "done": true},
    {
      "title": "Awaiting Site Readiness",
      "date": "09:30 AM, 9 May 2025",
      "done": true,
    },
    {
      "title": "Under Mechanical Installation",
      "date": "09:30 AM, 9 May 2025",
      "done": true,
    },
    {
      "title": "Under Electrical work",
      "date": "estimated date: 10 May 2025",
      "done": false,
    },
    {
      "title": "Under Testing & Commissioning",
      "date": "estimated date: 10 May 2025",
      "done": false,
    },
    {
      "title": "3rd Party Inspected",
      "date": "estimated date: 10 May 2025",
      "done": false,
    },
    {
      "title": "Awaiting Operation requirement",
      "date": "estimated date: 10 May 2025",
      "done": false,
    },
    {
      "title": "Handed over",
      "date": "estimated date: 10 May 2025",
      "done": false,
    },
    {"title": "Under FPMC", "date": "(10/08/2025)", "done": false},
    {"title": "Under Warranty", "date": "(12/08/2025)", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: Strings.contractsStatus.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s14.h,
                  horizontal: AppSize.s16.w,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(AppSize.s22.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(IconAssets.progressNote),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.s10.h,
                            horizontal: AppSize.s12.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffFF9408),
                            borderRadius: BorderRadius.circular(AppSize.s99.r),
                          ),
                          child: Text(
                            Strings.inProgress.tr(),
                            style: getMediumTextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: FontSizeManager.s16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(AppSize.s12.h),
                    Text(
                      Strings.newProductSupplyInstallation.tr(),
                      style: getMediumTextStyle(
                        color: ColorManager.whiteColor,
                        fontSize: FontSizeManager.s22.sp,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  final isFirst = index == 0;
                  final isLast = index == steps.length - 1;
                  return TimelineTile(
                    isFirst: isFirst,
                    isLast: isLast,
                    indicatorStyle: IndicatorStyle(
                      width: AppSize.s30.w,
                      height: AppSize.s30.h,
                      indicatorXY: 0.4,
                      indicator: step["done"] == true
                          ? SvgPicture.asset(IconAssets.progressDone)
                          : SvgPicture.asset(IconAssets.progressNotDone),
                    ),
                    beforeLineStyle: const LineStyle(
                      color: Color(0xFFBFC3CF),
                      thickness: 2,
                    ),
                    afterLineStyle: const LineStyle(
                      color: Color(0xFFBFC3CF),
                      thickness: 2,
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step["title"].toString(),
                            style: getMediumTextStyle(
                              color: step["done"] == true
                                  ? const Color(0xFF0C2144)
                                  : const Color(0xFF6C6C6C),
                              fontSize: FontSizeManager.s16.sp,
                            ),
                          ),
                          Gap(AppSize.s5.h),
                          Text(
                            step["date"].toString(),
                            style: getMediumTextStyle(
                              color: Color(0xFF9C9C9C),
                              fontSize: FontSizeManager.s14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}