import 'package:elevator/presentation/main/widgets/free_button.dart';
import 'package:elevator/presentation/main/widgets/home_bar.dart';
import 'package:elevator/presentation/main/widgets/premium_container.dart';
import 'package:elevator/presentation/main/widgets/registration_box.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  static const String homeRoute = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPremium = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeBar(),
            Gap(AppSize.s24.h),
            if (isPremium) ...[RegistrationBox(), Gap(AppSize.s24.h)],
            PremiumContainer(isPremium),
            Gap(AppSize.s24.h),
            Text(
              Strings.servicesTitle,
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s23.sp,
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(
              height: AppSize.s130.h,
              child: Row(
                children: [
                  FreeButton(
                    title: Strings.requestSiteSurvey,
                    imageAsset: ImageAssets.worker,
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        context: context,
                        builder: (BuildContext context) => Container(
                          width: AppSize.s402.w,
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
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(AppSize.s8.w),
                  FreeButton(
                    title: Strings.requestTechnicalOffer,
                    imageAsset: ImageAssets.note,
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
