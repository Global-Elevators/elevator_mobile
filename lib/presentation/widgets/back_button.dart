import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/navigation_service.dart';
import 'package:elevator/presentation/main/home/notification/notification_view.dart';
import 'package:elevator/presentation/resources/assets_manager.dart';
import 'package:elevator/presentation/resources/color_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BackButtonWidget extends StatelessWidget {
  final bool popOrGo;
  NavigationService navigationService = NavigationService(
    instance<AppPreferences>(),
  );

  BackButtonWidget({super.key, required this.popOrGo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => popOrGo
          ? context.pop()
          : navigationService.navigateWithAuthCheck(
              context: context,
              authenticatedRoute: NotificationView.notificationRoute,
            ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: AppSize.s45.h,
            width: AppSize.s45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14.r),
              border: Border.all(
                color: ColorManager.buttonsBorderColor,
                width: AppSize.s1.w,
              ),
            ),
          ),
          popOrGo
              ? Icon(Icons.arrow_forward_ios, color: ColorManager.primaryColor)
              : SvgPicture.asset(
                  ImageAssets.notification,
                  width: AppSize.s20.w,
                  height: AppSize.s20.h,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    ColorManager.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
        ],
      ),
    );
  }
}
