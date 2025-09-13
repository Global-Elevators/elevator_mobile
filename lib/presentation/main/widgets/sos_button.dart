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
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SosButton extends StatelessWidget {
  final bool isPremium;

  const SosButton(this.isPremium, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isPremium
          ? showModelOfSosSubscription(context)
          : showModelOfSosNotSubscription(context),
      child: Container(
        height: AppSize.s50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPremium
              ? ColorManager.errorColor
              : ColorManager.errorColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSize.s18.r),
        ),
        child: Text(
          Strings.sosTitle,
          style: TextStyle(
            fontFamily: "PlayfairDisplay",
            fontWeight: FontWeight.bold,
            fontSize: FontSizeManager.s24.sp,
            color: ColorManager.whiteColor,
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModelOfSosSubscription(BuildContext context) {
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
            sosImage(),
            Gap(AppSize.s18.h),
            sosTitle(),
            Gap(AppSize.s35.h),
            sosSubTitle(),
            Gap(AppSize.s35.h),
            ActionOrCancelButton(
              Strings.yesSendAlert,
              () {},
              actionColor: ColorManager.errorColor,
            ),
            Gap(AppSize.s16.h),
          ],
        ),
      ),
    );
  }

  Text sosSubTitle() {
    return Text(
      Strings.areYouSureYouWantToSendThisAlert,
      style: getMediumTextStyle(
        color: ColorManager.greyColor,
        fontSize: FontSizeManager.s18.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text sosTitle() {
    return Text(
      Strings.sosTitle,
      style: getBoldTextStyle(
        color: ColorManager.errorColor,
        fontSize: FontSizeManager.s22.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  SvgPicture sosImage() {
    return SvgPicture.asset(
      ImageAssets.sos,
      colorFilter: ColorFilter.mode(ColorManager.errorColor, BlendMode.srcIn),
    );
  }

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
            Align(
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
            ),
            SvgPicture.asset(
              ImageAssets.premium,
              height: AppSize.s100.h,
              width: AppSize.s100.w,
            ),
            Gap(AppSize.s18.h),
            RichText(
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
            ),
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

  Container contactButton() {
    return Container(
      height: AppSize.s60.h,
      decoration: BoxDecoration(
        color: ColorManager.orangeColor,
        borderRadius: BorderRadius.circular(AppSize.s14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.speaker,
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
      color: ColorManager.primaryColor,
      borderRadius: BorderRadius.circular(AppSize.s14.r),
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
}
