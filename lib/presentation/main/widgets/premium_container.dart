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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s22.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSize.s16.r),
        child: Column(
          children: [
            SosButton(isPremium),
            Gap(AppSize.s16.h),
            Row(
              children: [
                PremiumButton(
                  title: Strings.reportBreakDown,
                  imageAsset: ImageAssets.maintenance,
                  isPremium: isPremium,
                  onTap: () {},
                ),
                const Spacer(),
                PremiumButton(
                  title: Strings.requestVisitRescheduling,
                  imageAsset: ImageAssets.calendar,
                  isPremium: isPremium,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
