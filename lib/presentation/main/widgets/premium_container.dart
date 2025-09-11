import 'package:elevator/presentation/main/widgets/premium_button.dart';
import 'package:elevator/presentation/main/widgets/sos_button.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumContainer extends StatelessWidget {
  final bool isPremium;

  const PremiumContainer(this.isPremium, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color and opacity
            spreadRadius: 0, // How far the shadow spreads
            blurRadius: 15, // How blurry the shadow is
            offset: Offset(0, 0), // Changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSize.s8.r),
        child: Column(
          children: [
            SosButton(isPremium),
            Gap(AppSize.s16.h),
            SizedBox(
              height: AppSize.s120.h,
              child: Row(
                children: [
                  PremiumButton(
                    title: Strings.reportBreakDown,
                    imageAsset: ImageAssets.maintenance,
                    isPremium: isPremium,
                    onTap: () {},
                  ),
                  Gap( AppSize.s8.w),
                  PremiumButton(
                    title: Strings.requestVisitRescheduling,
                    imageAsset: ImageAssets.calendar,
                    isPremium: isPremium,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
