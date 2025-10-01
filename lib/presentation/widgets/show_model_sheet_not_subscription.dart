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
import 'package:go_router/go_router.dart';

Future<dynamic> showModelOfSosNotSubscription(BuildContext context) {
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
          cancelButton(context),
          premiumCardImage(),
          Gap(AppSize.s18.h),
          premiumCardText(),
          Gap(AppSize.s40.h),
          contactButton(),
          Gap(AppSize.s8.h),
          requestForQuotationButton(),
          Gap(AppSize.s16.h),
        ],
      ),
    ),
  );
}

RichText premiumCardText() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: Strings.premiumSubscriptionRequiredPart1,
      style: getMediumTextStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s17.sp,
      ),
      children: [
        TextSpan(
          text: Strings.contracts,
          style: getMediumTextStyle(
            color: Color(0xffF2982A),
            fontSize: FontSizeManager.s17.sp,
          ),
        ),
        TextSpan(
          text: Strings.premiumSubscriptionRequiredPart2,
          style: getMediumTextStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSizeManager.s17.sp,
          ),
        ),
      ],
    ),
  );
}

SvgPicture premiumCardImage() {
  return SvgPicture.asset(
    ImageAssets.premium,
    height: AppSize.s100.h,
    width: AppSize.s100.w,
  );
}

Align cancelButton(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: InkWell(
      onTap: () => context.pop(context),
      child: Container(
        height: AppSize.s45.h,
        width: AppSize.s45.w,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          shape: BoxShape.circle,
          border: Border.all(color: ColorManager.greyColor),
        ),
        child: Icon(
          Icons.close,
          color: ColorManager.primaryColor,
          size: AppSize.s30,
        ),
      ),
    ),
  );
}

Container contactButton() {
  return Container(
    height: AppSize.s60.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSize.s14.r),
      gradient: LinearGradient(
        colors: [Color(0xffFF930E), Color(0xff995808)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0],
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconAssets.speaker,
          height: AppSize.s18.h,
          width: AppSize.s18.w,
          colorFilter: ColorFilter.mode(
            ColorManager.whiteColor,
            BlendMode.srcIn,
          ),
        ),
        Gap(AppSize.s16.w),
        Text(
          Strings.contactSalesDept,
          style: getMediumTextStyle(
            color: ColorManager.whiteColor,
            fontSize: FontSizeManager.s18.sp,
          ),
        ),
      ],
    ),
  );
}

Container requestForQuotationButton() => Container(
  height: AppSize.s60.h,
  width: double.infinity.w,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSize.s14.r),
    gradient: LinearGradient(
      colors: [Color(0xff1C274C), Color(0xff364166)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
    ),
  ),
  child: Center(
    child: Text(
      textAlign: TextAlign.center,
      Strings.requestForQuotation,
      style: getMediumTextStyle(
        color: ColorManager.whiteColor,
        fontSize: FontSizeManager.s18.sp,
      ),
    ),
  ),
);
