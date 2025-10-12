import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/presentation/main/home/request_for_technical_view.dart';
import 'package:elevator/presentation/main/home/request_site_survey/request_site_survey_view.dart';
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
import 'package:go_router/go_router.dart';

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
        child: _HomePageBody(isPremium: isPremium),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final bool isPremium;

  const _HomePageBody({required this.isPremium});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeBar(),
        Gap(AppSize.s24.h),
        if (isPremium) ...[const RegistrationBox(), Gap(AppSize.s24.h)],
        PremiumContainer(isPremium),
        Gap(AppSize.s24.h),
        Text(
          Strings.servicesTitle.tr(),
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s23.sp,
            color: ColorManager.primaryColor,
          ),
        ),
        Gap(AppSize.s12.h),
        _ServicesRow(),
      ],
    );
  }
}

class _ServicesRow extends StatelessWidget {
  const _ServicesRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s130.h,
      child: Row(
        children: [
          FreeButton(
            title: Strings.requestSiteSurvey.tr(),
            imageAsset: IconAssets.worker,
            onTap: () => context.push(RequestSiteSurvey.requestSiteSurveyRoute),
          ),
          Gap(AppSize.s8.w),
          FreeButton(
            title: Strings.requestTechnicalOffer.tr(),
            imageAsset: ImageAssets.note,
            onTap: () =>
                context.push(RequestForTechnicalView.requestForTechnicalRoute),
          ),
        ],
      ),
    );
  }
}
