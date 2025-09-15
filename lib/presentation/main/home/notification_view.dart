import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/font_manager.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/styles_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationView extends StatefulWidget {
  static const String notificationRoute = '/notification';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          Strings.notifications,
          style: getBoldTextStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSizeManager.s28,
          ),
        ),
        actions: [BackButtonWidget(popOrGo: true), Gap(AppSize.s16.w)],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppSize.s16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.markAllAsRead,
              style: getMediumTextStyle(
                color: ColorManager.orangeColor,
                fontSize: FontSizeManager.s20,
              ),
            ),
            Gap(AppSize.s28.h),
            notificationItem(),
          ],
        ),
      ),
    );
  }

  Container notificationItem() => Container(
    padding: EdgeInsetsDirectional.symmetric(
      vertical: AppSize.s12.h,
      horizontal: AppSize.s14.w,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSize.s22.r),
      color: Color(0xffF8F8F9),//0xffF8F8F9
    ),
    child: Row(
      children: [
        Container(
          height: AppSize.s50.h,
          width: AppSize.s50.w,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s8.r),
          ),
          child: Icon(
            Icons.watch_later_outlined,
            color: ColorManager.primaryColor,
            size: AppSize.s24.h,
          ),
        ),
        Gap(AppSize.s12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.notificationTitle,
                style: getMediumTextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s18.sp,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                Strings.notificationSubTitle,
                style: getMediumTextStyle(
                  color: ColorManager.greyColor,
                  fontSize: FontSizeManager.s14.sp,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
