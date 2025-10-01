import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/action_or_cancel_button.dart';
import 'package:elevator/presentation/widgets/show_model_sheet_not_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SosButton extends StatelessWidget {
  final bool isPremium;

  const SosButton(this.isPremium, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isPremium
          ? showModelOfSosSubscription(context)
          : showModelOfSosNotSubscription(
              context,
            ), //showModelOfSosNotSubscription(context),
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
}
