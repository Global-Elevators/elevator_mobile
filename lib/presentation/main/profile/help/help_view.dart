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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatefulWidget {
  static const String routeName = '/help';

  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.help.tr(),
        showBackButton: true,
        popOrGo: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.contactUs.tr(),
              style: getMediumTextStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s28.sp,
              ),
            ),
            Gap(AppSize.s28.h),
            contactField(IconAssets.call, "+964 555 9988 778"),
            Gap(AppSize.s14.h),
            contactField(IconAssets.email, "support@elevator.com"),
            Gap(AppSize.s80.h),
            socialButtons(
              IconAssets.facebook,
              "https://www.facebook.com/momen.mohamed.10888",
              IconAssets.instagram,
              "https://www.instagram.com/?hl=en",
            ),
            Gap(AppSize.s16.h),
            socialButtons(
              IconAssets.web,
              "https://www.ge-elevators.com/",
              IconAssets.tiktok,
              "https://www.tiktok.com/explore",
            ),
          ],
        ),
      ),
    );
  }

  Row socialButtons(String icon1, String link1, String icon2, String link2) {
    return Row(
      children: [
        socialMediaItem(icon1, link1),
        Gap(AppSize.s16.w),
        socialMediaItem(icon2, link2),
      ],
    );
  }

  InkWell contactField(String icon, String title) => InkWell(
    onTap: () => title == "support@elevator.com"
        ? _launchUrl("mailto:sales@ge-elevators.com")
        : _launchUrl("tel:+9645559988778"),
    child: Row(
      children: [
        Container(
          height: AppSize.s50.h,
          width: AppSize.s50.w,
          decoration: BoxDecoration(
            color: Color(0xfff3f4f9),
            borderRadius: BorderRadius.circular(AppPadding.p12.r),
          ),
          child: SvgPicture.asset(
            icon,
            height: AppSize.s20.h,
            width: AppSize.s20.w,
            fit: BoxFit.scaleDown,
          ),
        ),
        Gap(AppSize.s16.w),
        Text(
          title,
          style: getMediumTextStyle(
            color: ColorManager.greyColor,
            fontSize: FontSizeManager.s22.sp,
          ),
        ),
      ],
    ),
  );

  static Future<void> _launchUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  socialMediaItem(String icon, String link) => Expanded(
    child: InkWell(
      onTap: () => _launchUrl(link),
      child: Container(
        height: AppSize.s60.h,
        decoration: BoxDecoration(
          color: Color(0xffF8F8F9),
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        child: icon == IconAssets.web
            ? Image.asset(
                icon,
                height: AppSize.s20.h,
                width: AppSize.s20.w,
                fit: BoxFit.scaleDown,
              )
            : SvgPicture.asset(
                icon,
                height: AppSize.s20.h,
                width: AppSize.s20.w,
                fit: BoxFit.scaleDown,
              ),
      ),
    ),
  );
}
